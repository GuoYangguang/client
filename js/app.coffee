require ["jquery", "cs!board/wcollection", "cs!board/wcollection_view",
"cs!board/collection", "cs!board/collection_view"],
($, Workspaces, WorkspacesView, Boards, BoardsView) ->
  
  $(document).ready ->
    workspaces = new Workspaces()
    workspacesView = new WorkspacesView({collection: workspaces})
    workspacesView.fetchWorkspaces()
    $("#fetchBoards").click ->
      workspace_id = $("h1").attr("data-workspace")
      boards = new Boards([], {workspace_id: workspace_id})
      boardsView = new BoardsView({collection: boards})
      boardsView.fetchBoards()
    
