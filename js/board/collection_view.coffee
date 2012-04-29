define ["jquery", "underscore", "backbone", "cs!board/model_view"], ($, _, Backbone, BoardView) ->
  class BoardsView extends Backbone.View
    tagName: "ul"

    initialize: ->
      this.collection.bind("reset", this.listBoards, this)

    listBoards: (boards) ->
      boards.each(this.appendBoard)
      $("#boards").after(this.el)
    
    appendBoard: (board) ->
      boardView = new BoardView({model: board})
      $(this.el).append(boardView.render().el)
     
       
