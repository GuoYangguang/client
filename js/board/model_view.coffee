define ["jquery", "underscore", "backbone", "text!templates/board.html", "libs/pure/pure"], 
($, _, Backbone, html) ->
  class BoardView extends Backbone.View 
    tagName: "li"

    render: ->
      
                      
      $(this.el).html(template)
      this
    
