define ["jquery", "underscore", "backbone", "text!templates/board.html"], 
($, _, Backbone, boardHtml) ->
  class BoardView extends Backbone.View 
    tagName: "li"
    
    initialize: ->
      $(this.el).html(boardHtml)
      $('ul#listBoards').append(this.el)
   
    events: {
      "click .board": "showBoard"
    }

    showBoard: ->
      console.log "clicking..."
      
    editBoard: ->
      console.log "dbclick"

    render: -> 
      data = this.model.toJSON()
      directives = {"span": "name"}
      $(this.el).render(data, directives)
      this
