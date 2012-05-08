define ["jquery", "underscore", "backbone", "cs!board/model_view"],
($, _, Backbone, BoardView) ->
  class BoardsView extends Backbone.View
    tagName: "ul"
    
    initialize: ->
      this.collection.bind("reset", this.listBoards, this)

    listBoards: ->
      ulObject = $(this.el) 
      this.collection.each (board)->
        boardView = new BoardView({model: board})
        ulObject.append(boardView.render().el)   
        boardView.insertData()
      $("#boards").after(ulObject)
      
      
     
       
