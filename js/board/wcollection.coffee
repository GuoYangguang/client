define ["jquery", "underscore", "backbone", "cs!board/wmodel", "cs!board/collection"], 
($, _, Backbone, Workspace, Boards)->
  class Workspaces extends Backbone.Collection
    
    model: Workspace
    
    url: "/workspaces" 
 
    initialize: ->
      this.bind("reset", -> 
        workspace = this.get(1)  
        Boards.workspace_id = workspace.get('id')
      )


