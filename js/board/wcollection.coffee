define ["jquery", "underscore", "backbone", "cs!board/wmodel"], 
($, _, Backbone, Workspace)->
  class Workspaces extends Backbone.Collection
    
    model: Workspace
    
    url: "/workspaces" 
 
    initialize: ->    
      this.bind "reset", ->
        workspace = this.get(1)
        $("h1").text(workspace.get("name"))
        $("#fetchBoards").attr("href", "#workspaces/#{workspace.id}/boards")
