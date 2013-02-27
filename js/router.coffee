define ['backbone', 
        'jquery',
        'cs!session/model',
        'cs!session/model_view',
        'cs!workspace/collection',
        'cs!workspace/collection_view'
], (Backbone, $, Session, SessionView, Workspaces, WorkspacesView)->
  
  class Router extends Backbone.Router

    routes: {
      '': 'boards',
      'login': 'login'
    }
    
    boards: ->
      workspaces = new Workspaces()
      workspacesView = new WorkspacesView({collection: workspaces})
      workspacesView.fetchWorkspaces()

    login: ->
      session = new Session()
      sessionView = new SessionView(model: session)
      $('#yield').html(sessionView.el)

