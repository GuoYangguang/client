define [
        "jquery", 
        "underscore", 
        "backbone", 
        "text!templates/workspace/collaborator/collaborator.html"
       ],
($, _, Backbone, colHtml)->
  
  class CollaboratorView extends Backbone.View
    tagName: "li" 

    render: ->
      data = this.model.toJSON()
      directives = {"span": "first"} 
      htmlWithData = $(colHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
