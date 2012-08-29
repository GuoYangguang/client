require ["jquery", 
         "cs!workspace/collection", 
         "cs!workspace/collection_view"
        ],
($, Workspaces, WorkspacesView) ->
  
  $(document).ready ->
    workspaces = new Workspaces()
    workspacesView = new WorkspacesView({collection: workspaces})
    workspacesView.fetchWorkspaces()
    
    
