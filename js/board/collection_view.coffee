define ["jquery", "underscore", "backbone", "cs!board/model_view"], ($, _, Backbone, BoardView) ->
  class BoardsView extends Backbone.View
    tagName: "ul"

    initialize: ->
      this.collection.bind("reset", this.listBoards, this)

    listBoards: (boards) ->
      ulObject = $(this.el) 
      boards.each (board)->
        boardView = new BoardView({model: board})
        ulObject.append(boardView.render().el)   
      $("#boards").after(this.el)
      
      
     
       
