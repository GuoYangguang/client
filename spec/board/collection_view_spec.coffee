require ["cs!board/collection_view", "cs!board/collection"], 
(BoardsView, Boards) ->
  describe "BoardsView", ->

    describe "initialize", ->
      beforeEach ->
        this.server = sinon.fakeServer.create()
        
      afterEach ->
        this.server.restore()

      it "bind a reset event to it when initialized with a collection instance", -> 
        
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",  
          [
           200, 
           {"Content-Type": "application/json"}, 
           '[{"name": "board1"}, {"name": "board2"}]'
          ]
        )
        boards = new Boards({workspace_id: 1})
        sinon.spy(BoardsView.prototype, "listBoards")
        boardsView = new BoardsView({collection: boards})
        boards.fetch()
        this.server.respond()
        expect(boards.length).toEqual 2
        expect(BoardsView.prototype.listBoards.calledWith(boards))
          .toBeTruthy()

        BoardsView.prototype.listBoards.restore()
