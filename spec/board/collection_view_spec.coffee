require ["cs!board/collection_view", "cs!board/collection"], (BoardsView, Boards) ->
  describe "BoardsView", ->

    describe "initialize", ->
      beforeEach ->
        this.server = sinon.fakeServer.create()
      afterEach ->
        this.server.restore()

      it "bind a reset event to it when initialized a view with a collection instance", -> 
        
        this.server.respondWith(
          "GET",
          "/boards",  
          [
           200, 
           {"Content-Type": "application/json"}, 
           '[{"name": "board1"}, {"name": "board2"}]'
          ]
        )
        boards = new Boards()
        boardsView = new BoardsView({collection: boards})
        sinon.spy(boardsView, "listBoards")
        boards.fetch()
        this.server.respond()
        expect(boards.length).toEqual 2
        #boards.each (board)-> console.log board

        boardsView.listBoards.restore()
