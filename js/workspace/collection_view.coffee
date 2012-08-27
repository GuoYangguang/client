define [
        "jquery", 
        "underscore", 
        "backbone",
        "cs!workspace/collaborator/collection",
        "cs!workspace/collaborator/collection_view"
       ],  
($, _, Backbone, Collaborators, CollaboratorsView)->

  class WorkspacesView extends Backbone.View 

    initialize: ->
      this.collection.bind("reset", this.render, this)

    fetchWorkspaces: ->
      this.collection.fetch(wait: true, 
        success: this.successFetch, error: this.errorFetch)
    
    successFetch: (collection, response)->
      workspace = collection.get(1)
      collaborators = new Collaborators([], {workspaceId: workspace.id})
      colsView = new CollaboratorsView(collection: collaborators)
      colsView.fetchCols()

    errorFetch: (collection, response)->

    render: ->
      workspace = this.collection.get(1)
      $("#workspace").text(workspace.get("name"))
      $("#workspace").attr("data-workspace", workspace.id)
 
       
