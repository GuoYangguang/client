define ["jquery", "underscore", "backbone", "cs!board/wcollection", 
"cs!board/collection", "cs!board/collection_view"], 
($, _, Backbone, Workspaces, Boards, BoardsView) ->
  class Router extends Backbone.Router

    initialize: ->
      workspaces = new Workspaces()
      workspaces.fetch()

    routes: {
      "workspaces/:workspace_id/boards": "listBoards"
    }

    listBoards: (workspace_id)->
      boards = new Boards([], {workspace_id: workspace_id})
      boardsView = new BoardsView({collection: boards}) 
      boards.fetch()
