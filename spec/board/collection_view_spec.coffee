require ["cs!board/collection_view", "cs!board/collection"], 
(BoardsView, Boards) ->
  describe "BoardsView", ->
    beforeEach ->
      this.server = sinon.fakeServer.create()
      this.jsonData = [{"id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
      "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"},        
      {"id":2,"name":"board2","entity_id":1,"workspace_id":1,"user_id":1,
      "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"}]
    
    afterEach ->
      this.server.restore()

    describe "initialize", ->
      it "bind a reset event to the collection", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",  
          [
           200, 
           {"Content-Type": "application/json"}, 
           JSON.stringify this.jsonData
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
    
    describe "listBoards", ->
      it "inserts the boards collection data into page", ->
        this.jsonData 



