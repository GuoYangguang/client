define ["jquery", "underscore", "backbone"],  
($, _, Backbone) ->

  class WorkspacesView extends Backbone.View 

    initialize: ->
      this.collection.bind("reset", this.render, this)

    fetchWorkspaces: ->
      this.collection.fetch()

    render: ->
      workspace = this.collection.get(1)
      $("h1").text(workspace.get("name"))
      $("#fetchBoards").attr("data-workspace", workspace.id)
    
