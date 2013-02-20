define [
  'backbone',
  'jquery',
  'text!templates/session/session.html',
  'cs!user/model',
  'cs!user/model_view'
], (Backbone, $, sessionHtml, User, UserView)->
  
  class SessionView extends Backbone.View
    
    className: 'login'

    initialize: (options)->
      @$el.html sessionHtml
      user = new User()
      @userView = new UserView(model: user)

    events: {
      'click #register-btn1': 'displayRegister' 
    }

    displayRegister: ->
      @$el.after(@userView.el)
      @userView.$el.slideDown('slow', ->)
