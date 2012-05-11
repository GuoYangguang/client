define ["jquery", "underscore", "backbone", "text!templates/board.html"], 
($, _, Backbone, boardHtml) ->
  class BoardView extends Backbone.View 
    tagName: "li"
    
    initialize: ->
      $(this.el).html(boardHtml)

    render: -> 
      data = this.model.toJSON()
      directives = {"span": "name"}
      $(this.el).render(data, directives)
      this
