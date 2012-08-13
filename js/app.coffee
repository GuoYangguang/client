require ["jquery", 
         "cs!workspace/collection", 
         "cs!workspace/collection_view",
         "cs!workspace/board/collection", 
         "cs!workspace/board/collection_view"
        ],
($, Workspaces, WorkspacesView, Boards, BoardsView) ->
  
  $(document).ready ->
    workspaces = new Workspaces()
    workspacesView = new WorkspacesView({collection: workspaces})
    workspacesView.fetchWorkspaces()
    $("#fetch-boards").click ->
      workspace_id = $("#workspace").attr("data-workspace")
      boards = new Boards([], {workspace_id: workspace_id})
      boardsView = new BoardsView({collection: boards})
      boardsView.fetchBoards()
