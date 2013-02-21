define ['backbone', 
        'jquery',
        'cs!session/model',
        'cs!session/model_view'
], (Backbone, $, Session, SessionView)->
  
  class Router extends Backbone.Router

    routes: {
      '': 'boards',
      'login': 'login'
    }
    
    boards: ->

    login: ->
      session = new Session()
      sessionView = new SessionView(model: session)
      $('#yield').html(sessionView.el)

