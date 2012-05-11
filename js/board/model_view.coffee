define ["jquery", "underscore", "backbone", "text!templates/board.html"], 
($, _, Backbone, boardHtml) ->
  class BoardView extends Backbone.View 
    tagName: "div"

    render: -> 
      $(this.el).html(boardHtml)
      this

    insertData: ->
      data = this.model.toJSON()
      directives = {"span": "name"}
      $(this.el).render(data, directives)
    
