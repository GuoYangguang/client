require ["jquery", "cs!board/collection_view", "cs!board/collection", "cs!board/model", 
"text!templates/boards.html"], ($, BoardsView, Boards, Board, boardsHtml) ->

  describe "BoardsView", ->
    beforeEach ->
      this.server = sinon.fakeServer.create()
      this.data = [
        {"id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"},        
        {"id":2,"name":"board2","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-08 19:48:10","updated_at":"2012-05-07 19:48:10"}
      ]

      this.invalidData = {"name":"","entity_id":1,"workspace_id":1,"user_id":1}
      
      this.boards = new Boards()

    afterEach ->
      this.server.restore()
    
    describe "el", ->
      it "sets the 'div' as the root tag ", ->
        boardsView = new BoardsView({collection: this.boards})
        expect(boardsView.tagName).toEqual 'div'

    describe "initialize", ->
      it "appends the 'boards' template into el", ->
        boardsView = new BoardsView({collection: this.boards})
        expect($(boardsView.el).html()).toEqual boardsHtml 

      it "binds a reset event to the collection", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",  
          [
           200, 
           {"Content-Type": "application/json"}, 
           JSON.stringify this.data
          ]
        )
        
        sinon.spy(BoardsView.prototype, "render")
        
        boardsView = new BoardsView({collection: this.boards})
        this.boards.fetch()
        this.server.respond()

        expect(this.boards.length).toEqual 2
        expect(BoardsView.prototype.render.calledOnce)
          .toBeTruthy()

        BoardsView.prototype.render.restore()

      it "binds a add event to the collection", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards",
          [201,
           {"Content-Type": "application/json"},
           JSON.stringify this.data[0]
          ]
        ) 
        sinon.spy(BoardsView.prototype, "appendBoard")

        boardsView = new BoardsView({collection: this.boards})
        this.boards.create({name: 'board1'})
        this.server.respond()
        createdBoard = this.boards.at(0)

        expect(this.boards.length).toEqual 1
        expect(BoardsView.prototype.appendBoard.calledWith(createdBoard))
          .toBeTruthy()

        BoardsView.prototype.appendBoard.restore()
      
    describe "fetchBoards", ->
      it "triggers success callback if the server returns 200 ", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",
          [200, {"Content-Type": "application/json"}, JSON.stringify(this.data)]
        ) 
        sinon.spy(BoardsView.prototype, "successFetch")
        boardsView = new BoardsView({collection: this.boards})
        
        boardsView.fetchBoards()
        this.server.respond()

        expect(this.boards.length).toEqual 2
        expect(BoardsView.prototype.successFetch.calledOnce).toBeTruthy()
        
        BoardsView.prototype.successFetch.restore()
      
      it "triggers error callback if the server returns 4**", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",
          [404, {}, ""]
        ) 
        sinon.spy(BoardsView.prototype, "errorFetch")
        boardsView = new BoardsView({collection: this.boards}) 
       
        boardsView.fetchBoards()
        this.server.respond()

        expect(this.boards.length).toEqual 0
        expect(BoardsView.prototype.errorFetch.calledOnce).toBeTruthy()

        BoardsView.prototype.errorFetch.restore()
        
    describe "listBoards", ->
      it "inserts a boards collection into into 'ul' node of el", ->
        models = new Array()
        for e in this.data by 1
          models.push new Board(e)
        boards = new Boards(models,{workspace_id: 1})
        boardsView = new BoardsView({collection: boards})
        
        boardsView.listBoards()
        expect($(boardsView.el).find('ul li:eq(0) span:eq(0)').text())
          .toEqual this.data[0].name

        expect($(boardsView.el).find('ul li:eq(1) span:eq(0)').text())
          .toEqual this.data[1].name

    describe "appendBoard", ->
      it "appends a board into 'ul' node of el", ->
        boardsView = new BoardsView({collection: this.boards})
        board = new Board(this.data[0])
        
        boardsView.appendBoard(board)

        expect($(boardsView.el).find("ul span:first").text())
          .toEqual this.data[0].name
        
    describe "createBoard", ->
      it "invokes the success callback if the server returns 201", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards",
          [201, {"Content-Type": "application/json"}, 
          JSON.stringify this.data[0]]
        )
        sinon.spy(BoardsView.prototype, "successCreate")
        boardsView = new BoardsView({collection: this.boards})
        expect(this.boards.length).toEqual 0 
        
        boardsView.createBoard()
        this.server.respond()

        expect(this.boards.length).toEqual 1
        expect(BoardsView.prototype.successCreate.calledOnce).toBeTruthy()

        BoardsView.prototype.successCreate.restore()

      it "invokes the error callback if the server returns 4**", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards", 
          [400, {"Content-Type": "application/json"}, 
          JSON.stringify(this.invalidData)]
        ) 
        sinon.spy BoardsView.prototype, "errorCreate"
        boardsView = new BoardsView({collection: this.boards})

        boardsView.createBoard()
        this.server.respond()

        expect(this.boards.length).toEqual 0 
        expect(BoardsView.prototype.errorCreate.calledOnce).toBeTruthy()

        BoardsView.prototype.errorCreate.restore()

    
