define ["jquery", "underscore", "backbone", "text!../templates/board"], ($, _, Backbone, html) ->
  class BoardView extends Backbone.View 
    
    template: $(html)
    
    render: ->
      this.template.directives({"li": "name"})
        .render(JSON.stringify(this.model))
    
    
     
