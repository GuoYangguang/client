define [
  'backbone', 
  'jquery',
  'cs!menu/view.logged.menu',
  'cs!menu/view.logout.menu',
  'cs!session/session',
  'cs!session/view.session',
  'cs!user/user',
  'cs!user/view.user',
  'cs!board/boards', 
  'cs!board/view.boards'
], (Backbone, $, LoggedMenuView, LogoutMenuView, Session, SessionView, User, 
    UserView, Boards, BoardsView)->
  
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
      session = new Session()
      loggedMenuView = new LoggedMenuView(model: session)
      $('#content').html(loggedMenuView.el).append(boardsView.el)

    session: ->
      session = new Session()
      sessionView = new SessionView(model: session)
      @clearView(sessionView)
      logoutMenuView = new LogoutMenuView()
      $('#content').append(logoutMenuView.el).append(sessionView.el)
    
    createUser: ->
      user = new User()
      userView = new UserView(model: user)     
      @clearView(userView)
      $('#content').append(userView.el)
