require ["jquery", 
         "cs!workspace/board/collection_view", 
         "cs!workspace/board/collection", 
         "cs!workspace/board/model", 
         "text!templates/workspace/board/boards.html"
        ], 
($, BoardsView, Boards, Board, boardsHtml) ->

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
      
      this.boards = new Boards([], {workspace_id: 1})

    afterEach ->
      this.server.restore()
    
    describe "el", ->
      it "sets the 'div' as the root tag ", ->
        boardsView = new BoardsView({collection: this.boards})
        expect(boardsView.tagName).toEqual 'div'

    describe "initialize", ->
      it "binds a callback to the collection's reset event", -> 
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

      it "binds a callback to the collection's add event", ->
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
      it "triggers success and reset callbacks if fetching successfully ", ->
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",
          [200, {"Content-Type": "application/json"}, JSON.stringify(this.data)]
        ) 
        sinon.spy(BoardsView.prototype, "successFetch")
        sinon.spy(BoardsView.prototype, "render")
        boardsView = new BoardsView({collection: this.boards})
        
        boardsView.fetchBoards()
        this.server.respond()

        expect(this.boards.length).toEqual 2
        expect(BoardsView.prototype.successFetch.calledOnce).toBeTruthy()
        expect(BoardsView.prototype.render.calledOnce).toBeTruthy()
        
        BoardsView.prototype.successFetch.restore()
        BoardsView.prototype.render.restore()
      
      it "triggers error callback,but not reset callback if failing to fetch", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",
          [404, {}, ""]
        ) 
        sinon.spy(BoardsView.prototype, "errorFetch")
        sinon.spy(BoardsView.prototype, "render")
        boardsView = new BoardsView({collection: this.boards}) 
       
        boardsView.fetchBoards()
        this.server.respond()

        expect(this.boards.length).toEqual 0
        expect(BoardsView.prototype.errorFetch.calledOnce).toBeTruthy()
        expect(BoardsView.prototype.render.calledOnce).toEqual(false)

        BoardsView.prototype.errorFetch.restore()
        BoardsView.prototype.render.restore()
        
    describe "render", ->
      it "inserts a boards collection into into 'ul' node of el", ->
        models = new Array()
        for e in this.data by 1
          models.push new Board(e)
        boards = new Boards(models,{workspace_id: 1})
        boardsView = new BoardsView({collection: boards})
        
        boardsView.render()

        expect($(boardsView.el).find('ul li:eq(0) span:eq(0)').text())
          .toEqual this.data[0].name

        expect($(boardsView.el).find('ul li:eq(1) span:eq(0)').text())
          .toEqual this.data[1].name

        
    describe "createBoard", ->
      it "triggers the success and add callbacks if the server returns 201", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards",
          [201, {"Content-Type": "application/json"}, 
          JSON.stringify this.data[0]]
        )
        sinon.spy(BoardsView.prototype, "successCreate")
        sinon.spy(BoardsView.prototype, "appendBoard")
        boardsView = new BoardsView({collection: this.boards})
        expect(this.boards.length).toEqual 0 
        
        boardsView.createBoard()
        this.server.respond()

        expect(this.boards.length).toEqual 1
        expect(BoardsView.prototype.successCreate.calledOnce).toBeTruthy()
        expect(BoardsView.prototype.appendBoard.calledOnce).toBeTruthy()

        BoardsView.prototype.successCreate.restore()
        BoardsView.prototype.appendBoard.restore()

      it "triggers the error callback,but not add callback 
        if the server returns 4**", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards", 
          [400, {"Content-Type": "application/json"}, 
          JSON.stringify(this.invalidData)]
        ) 
        sinon.spy BoardsView.prototype, "errorCreate"
        sinon.spy BoardsView.prototype, "appendBoard"
        boardsView = new BoardsView({collection: this.boards})

        boardsView.createBoard()
        this.server.respond()

        expect(this.boards.length).toEqual 0 
        expect(BoardsView.prototype.errorCreate.calledOnce).toBeTruthy()
        expect(BoardsView.prototype.appendBoard.calledOnce).toEqual(false)

        BoardsView.prototype.errorCreate.restore()
        BoardsView.prototype.appendBoard.restore()

    
