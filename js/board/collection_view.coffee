define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  class BoardsView extends Backbone.View
    initialize: ->
      this.collection.bind "reset", this.listBoards, this

    listBoards: (boards) ->
      boards.each()

    appendBoard: (board) ->
      boardView = new BoardView(board)
      boardView.render()
      $("#boards").append()
     
       
