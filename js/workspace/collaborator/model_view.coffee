define [
        "jquery", 
        "underscore", 
        "backbone", 
        "text!templates/workspace/collaborator/collaborator.html"
       ],
($, _, Backbone, colHtml)->
  
  class CollaboratorView extends Backbone.View
    
    render: ->
      data = this.model.toJSON()
      directives = {"span": "last"} 
      htmlWithData = $(colHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
