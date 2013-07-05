define [
  'backbone',
  'text!templates/menu/logout.html'
], (Backbone, logoutMenuHtml)->

  class LogoutMenuView extends Backbone.View

    initialize: (options)->
      @$el.html(logoutMenuHtml)
     
    events: {
        
    }
