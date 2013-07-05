define [
  'backbone', 
  'jquery',
  'cs!token_user/token_user',
  'cs!token_user/token_user.view'
], (Backbone, $, TokenUser, TokenUserView)->
  
  class Router extends Backbone.Router
    
    initialize: (options)->
    
    routes: {
      '': 'home',
    }
   
    clearView: (view)->
      if @currentView?
        @currentView.off()
        @currentView.remove()
      @currentView = view 
      
    home: ->
      tokenUser = new TokenUser()
      tokenUserView = new TokenUserView(model: tokenUser)
      #$('#content').html(loggedMenuView.el).append(boardsView.el)

    
