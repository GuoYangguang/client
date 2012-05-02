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
      $("#workspace").text("workspace1 has been updated with data")
    
    listBoards: ->
      boards = new Boards()
      $("#boards").after("<ul><li>board1</li></ul>")      
