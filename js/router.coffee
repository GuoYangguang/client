define ['backbone', 
        'jquery',
        'cs!session/session',
        'cs!session/view.session',
        'cs!user/user',
        'cs!user/view.user',
        'cs!board/boards', 
        'cs!board/view.boards'
], (Backbone, $, Session, SessionView, User, UserView, Boards, BoardsView)->
  
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
      boards = new Boards()
      boardsView = new BoardsView({collection: boards})
      @clearView(boardsView)
      boardsView.fetchBoards()

    session: ->
      session = new Session()
      sessionView = new SessionView(model: session)
      @clearView(sessionView)
      $('#content').html(sessionView.el)
    
    createUser: ->
      user = new User()
      userView = new UserView(model: user)     
      @clearView(userView)
      $('#content').html(userView.el)
