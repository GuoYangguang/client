require ["jquery", "cs!board/model", "cs!board/model_view", "text!templates/board.html"],
($, Board, BoardView, boardHtml)->
  describe "BoardView", ->

    beforeEach ->
      this.server = sinon.fakeServer.create()
      
      this.data = {
        "id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"
      }
      this.board = new Board(this.data)
      this.board.url = "/workspaces/1/boards/1"
      this.boardView = new BoardView({model: this.board})
    
    afterEach ->
      this.server.restore()

    describe "el", ->
      it "sets el's root tag to be 'li'", ->
        expect(this.boardView.tagName).toEqual "li"
    
    describe "initialize", ->
      it "binds a callback to the model's destroy event", ->
        this.server.respondWith(
          "DELETE",
          "/workspaces/1/boards/1",
          [204, {}, ""]
        )
        sinon.spy(BoardView.prototype, "destroyCal")
        
        boardView = new BoardView(model: this.board)
        boardView.deleteBoard()        
        this.server.respond()

        expect(BoardView.prototype.destroyCal.calledOnce).toBeTruthy()

        BoardView.prototype.destroyCal.restore()

    describe "template", ->
      it "initializes a jquery object with 'boardHtml' template", ->
        expect(this.boardView.template.html()).toEqual($(boardHtml).html())
     
    describe "showBoard", ->
      it "triggers the success callback if fetching successfully", ->
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards/1",
          [200,
           {"Content-Type": "application/json"},
           JSON.stringify(this.data)
          ]
        )
        sinon.spy(BoardView.prototype, "successFetch")
           
        this.boardView.showBoard()
        this.server.respond()

        expect(BoardView.prototype.successFetch.calledOnce).toBeTruthy()

        BoardView.prototype.successFetch.restore()

      it "triggers the error callback if fails to fetch", -> 
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards/1",
          [404, {}, ""]
        )
        sinon.spy(BoardView.prototype, "errorFetch")
        
        this.boardView.showBoard()
        this.server.respond()
       
        expect(BoardView.prototype.errorFetch.calledOnce).toBeTruthy()

        BoardView.prototype.errorFetch.restore()

    describe "deleteBoard", ->    
      it "triggers the success and destroy callbacks if deleting the board 
        successfully", ->

        this.server.respondWith(
          "DELETE",
          "/workspaces/1/boards/1",
          [204, {}, ""]
        )
        sinon.spy(BoardView.prototype, "destroyCal")
        boardView = new BoardView({model: this.board})
        sinon.spy(BoardView.prototype, "successDel")

        boardView.deleteBoard() 
        this.server.respond()

        expect(BoardView.prototype.successDel.calledOnce).toBeTruthy()
        expect(BoardView.prototype.destroyCal.calledOnce).toBeTruthy()

        BoardView.prototype.successDel.restore()
        BoardView.prototype.destroyCal.restore()
      
      it "triggers the error callback, 
        but not destroy callback if failing to delete the board", ->
        this.server.respondWith(
          "DELETE", 
          "/workspaces/1/boards/1",
          [404, {}, ""]
        )
        sinon.spy(BoardView.prototype, "destroyCal")
        boardView = new BoardView({model: this.board})
        sinon.spy(BoardView.prototype, "errorDel")

        this.boardView.deleteBoard()
        this.server.respond()
        
        expect(BoardView.prototype.errorDel.calledOnce).toBeTruthy()
        expect(BoardView.prototype.destroyCal.calledOnce).toEqual(false)
        
        BoardView.prototype.errorDel.restore()
        BoardView.prototype.destroyCal.restore()
    
         
    describe "render", ->
      it "inserts 'template' with the model data into 'el'", ->
        this.boardView.render()

        expect($(this.boardView.el).find("span:first").text())
          .toEqual this.data.name
