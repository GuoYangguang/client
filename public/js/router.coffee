define ->
  class AppRouter extends Backbone.Router 
    routes: {
      "workspaces/:workspace_id": "showWorkspace"
    
    }

    showWorkspace: (id)-> console.log "i am workspace#{id}"
      
