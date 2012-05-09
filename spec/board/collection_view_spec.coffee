require ["jquery", "cs!board/collection_view", "cs!board/collection", "cs!board/model", 
"text!templates/boards.html"], ($, BoardsView, Boards, Board, html) ->

  describe "BoardsView", ->
    beforeEach ->
      this.server = sinon.fakeServer.create()
      this.data = [{"id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
      "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"},        
      {"id":2,"name":"board2","entity_id":1,"workspace_id":1,"user_id":1,
      "created_at":"2012-05-08 19:48:10","updated_at":"2012-05-07 19:48:10"}]
      
      this.boards = new Boards([], {workspace_id: 1})

    afterEach ->
      this.server.restore()
    
    describe "el", ->
      it "sets the 'div' as the root tag ", ->
        boardsView = new BoardsView({collection: this.boards})
        expect(boardsView.tagName).toEqual 'div'

    describe "initialize", ->
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
        createdBoard = this.boards.create({name: 'board1'})
        this.server.respond()

        expect(this.boards.length).toEqual 1
        expect(BoardsView.prototype.appendBoard.calledWith(createdBoard))
          .toBeTruthy()

        BoardsView.prototype.appendBoard.restore()
      
      it "appends the 'boards' template into el", ->
        boardsView = new BoardsView({collection: this.boards})
        expect($(boardsView.el).html()).toEqual html
      
    describe "render", ->
      it "inserts the boards collection into page", ->
        models = new Array()
        for e in this.data by 1
          models.push new Board(e)
        boards = new Boards(models,{workspace_id: 1})
        boardsView = new BoardsView({collection: boards})
        
        boardsView.render()

        expect($(boardsView.el).find('span:first').text())
          .toEqual this.data[0].name

        
    describe "createBoard", ->
      it "creates a board", ->
        boardsView = new BoardsView({collection: this.boards})
        expect(this.boards.length).toEqual 0 
        
        boardsView.createBoard()

        expect(this.boards.length).toEqual 1

    describe "appendBoard", ->
      it "inserts a board data into 'li' tag and append it into 'ul' tag of el", ->
        boardsView = new BoardsView({collection: this.boards})
        board = new Board(this.data[0])
        
        boardsView.appendBoard(board)

        expect($(boardsView.el).find("ul li span:first").text())
          .toEqual this.data[0].name

          
