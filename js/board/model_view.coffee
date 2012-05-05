define ["jquery", "underscore", "backbone", "text!templates/board.html"], 
($, _, Backbone, html) ->
  class BoardView extends Backbone.View 
    tagName: "li"

    render: -> 
      $(this.el).html(html)
      this

    insertData: ->
      data = this.model.toJSON()
      directives = {"span": "name"}
      $(this.el).render(data, directives)
    
