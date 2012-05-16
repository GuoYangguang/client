require ["jquery", "cs!board/model", "cs!board/model_view", "text!templates/board.html"],
($, Board, BoardView, boardHtml)->
  describe "BoardView", ->

    beforeEach ->
      this.data = {
        "id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"
      }
      this.board = new Board(this.data)
      this.boardView = new BoardView({model: this.board})
    
    describe "el", ->
      it "sets el's root tag to be 'li'", ->
        expect(this.boardView.tagName).toEqual "li"
    
    describe "template", ->
      it "initializes a jquery object with 'boardHtml' template", ->
        expect(this.boardView.template.html()).toEqual($(boardHtml).html())
      
    describe "render", ->
      it "inserts 'template' with the model data into 'el'", ->
        this.boardView.render()

        expect($(this.boardView.el).find("span:first").text())
          .toEqual this.data.name

    
