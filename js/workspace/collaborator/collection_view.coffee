define [
        "jquery", 
        "underscore", 
        "backbone", 
        "cs!workspace/collaborator/model_view",
        "text!templates/workspace/collaborator/collaborators.html"
       ],
($, _, Backbone, CollaboratorView, colsHtml)->
  
  class CollaboratorsView extend Backbone.View
    
    initialize: ->
      this.collection.bind("reset", this.render, this)
    
    fetchCols: ->
      this.collection.fetch(wait: true, 
        success: this.successFetch, error: this.errorFetch)
        
    successFetch: (collection, response)->

    errorFetch: (collection, response)->

    render: ->
      ulNode = $(this.el).html(colsHtml).find("ul")
      this.collection.each (collaborator)->
        colView = new CollaboratorView(model: collaborator) 
        unNode.append($(colView.render().el).html())
      this
    
