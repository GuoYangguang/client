define ['backbone', 
        'jquery',
        'cs!session/model',
        'cs!session/view.model',
        'cs!user/model',
        'cs!user/view.model'
], (Backbone, $, Session, SessionView, User, UserView)->
  
  class Router extends Backbone.Router
    
    initialize: (options)->
    
    routes: {
      '': 'home',
      'login': 'session',
      'signup': 'createUser'
    }
   
    clearView: (view)->
      if @currentView?
        @currentView.off()
        @currentView.remove()
      @currentView = view 
      
    home: ->
      console.log 'logged'

    session: ->
      session = new Session()
      sessionView = new SessionView(model: session)
      @clearView(sessionView)
      $('#yield').append(sessionView.el)
    
    createUser: ->
      user = new User()
      userView = new UserView(model: user)     
      @clearView(userView)
      $('#yield').append(userView.el)
