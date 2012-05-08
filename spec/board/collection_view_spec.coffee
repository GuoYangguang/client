require ["jquery", "cs!board/collection_view", "cs!board/collection", "cs!board/model"], 
($, BoardsView, Boards, Board) ->
  describe "BoardsView", ->
    beforeEach ->
      this.server = sinon.fakeServer.create()
      this.data = [{"id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
      "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"},        
      {"id":2,"name":"board2","entity_id":1,"workspace_id":1,"user_id":1,
      "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"}]
    
    afterEach ->
      this.server.restore()
    
    describe "el", ->
      it "sets the 'ul' as the root tag ", ->
        boards = new Boards({workspace_id: 1})
        
        boardView = new BoardsView({collection: boards})

        expect(boardView.tagName).toEqual 'ul'

    describe "initialize", ->
      it "bind a reset event to the collection", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards",  
          [
           200, 
           {"Content-Type": "application/json"}, 
           JSON.stringify this.data
          ]
        )
        boards = new Boards({workspace_id: 1})
        sinon.spy(BoardsView.prototype, "listBoards")

        boardsView = new BoardsView({collection: boards})
        boards.fetch()
        this.server.respond()

        expect(boards.length).toEqual 2
        expect(BoardsView.prototype.listBoards.calledOnce)
          .toBeTruthy()
        BoardsView.prototype.listBoards.restore()
    
    describe "listBoards", ->
      it "inserts the boards collection data into page", ->
        models = new Array()
        for e in this.data by 1
          models.push new Board(e)
        boards = new Boards(models)
        boardsView = new BoardsView({collection: boards})
        
        boardsView.listBoards()

        expect($(boardsView.el).find('span:first').text())
          .toEqual this.data[0].name

        


