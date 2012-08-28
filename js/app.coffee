require ["jquery", 
         "cs!workspace/collection", 
         "cs!workspace/collection_view"
        ],
($, Workspaces, WorkspacesView) ->
  
  $(document).ready ->
    workspaces = new Workspaces()
    workspacesView = new WorkspacesView({collection: workspaces})
    workspacesView.fetchWorkspaces()
    $("body").html(workspacesView.el)
    #$("#fetch-boards").click ->
    #  workspace_id = $("#workspace").attr("data-workspace")
    #  boards = new Boards([], {workspace_id: workspace_id})
    #  boardsView = new BoardsView({collection: boards})
    #  boardsView.fetchBoards()
    
    
