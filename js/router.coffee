define ["jquery", "underscore", "backbone", "cs!board/wcollection", "cs!board/collection"], 
($, _, Backbone, Workspaces, Boards) ->
  class Router extends Backbone.Router
    routes: {
      "": "showWorkspace",
      "boards": "listBoards"
    }

    showWorkspace: ->
      workspaces = new Workspaces()
      workspaces.fetch()
      workspace = workspaces.get(1)
      console.log workspace
      $("#workspace").text(workspace.get("name"))
      $("#workspace_id").val(workspace.id)
    
    listBoards: ->
      workspace_id = $("#workspace_id").val()
      boards = new Boards({workspace_id: workspace_id})
      console.log boards
      boards.fetch()
      #$("#boards").after("<ul><li>board1</li></ul>")      
