define ["jquery", "underscore", "backbone", "text!../templates/board.html"], ($, _, Backbone, html) ->
  class BoardView extends Backbone.View 
    tagName: "li"

    template: $(html)
    
    render: ->
      this.template.directives({"span": "name"})
        .render(JSON.stringify(this.model))
      $(this.el).html(this.template)
      this
    
    
     
