define [
  "backbone", 
  "cs!board/board"
],(Backbone, Board)-> 

  class Boards extends Backbone.Collection
    model: Board
    
    initialize: (models, options)->
      @currentPage = 0 

    url: ->
      "/boards"  

      
