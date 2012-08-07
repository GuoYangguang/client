define ["jquery", "underscore", "backbone"],  
($, _, Backbone) ->

  class WorkspacesView extends Backbone.View 

    initialize: ->
      this.collection.bind("reset", this.render, this)

    fetchWorkspaces: ->
      this.collection.fetch()

    render: ->
      workspace = this.collection.get(1)
      $("#workspace").text(workspace.get("name"))
      $("#workspace").attr("data-workspace", workspace.id)
    
