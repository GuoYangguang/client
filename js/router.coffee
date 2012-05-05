define ["jquery", "underscore", "backbone", "cs!board/wcollection", 
"cs!board/collection", "cs!board/collection_view"], 
($, _, Backbone, Workspaces, Boards, BoardsView) ->
  class Router extends Backbone.Router
    routes: {
      "": "showWorkspace",
      "boards": "listBoards"
    }

    showWorkspace: ->
      workspaces = new Workspaces()
      workspaces.fetch()
      
    listBoards: ->
      workspace_id = $("#workspace_id").val()
      boards = new Boards({workspace_id: workspace_id})
      boardsView = new BoardsView({collection: boards}) 
      boards.fetch()
