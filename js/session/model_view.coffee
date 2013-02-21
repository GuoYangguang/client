define [
  'backbone',
  'jquery',
  'text!templates/session/session.html',
  'cs!user/model',
  'cs!user/model_view',
  'cs!helper'
], (Backbone, $, sessionHtml, User, UserView, Helper)->
  
  class SessionView extends Backbone.View
    
    className: 'login'

    initialize: (options)->
      @$el.html sessionHtml
      user = new User()
      @userView = new UserView(model: user)

    events: {
      'click #register-btn1': 'displayRegister', 
      'click #login-btn': 'login'
    }
    
    login: ->
      email = @$el.find('input[name="login-email"]').val()
      password = @$el.find('input[name="login-password"]').val()
      loginData = {
        email: email,
        password: password
      }
      @model.save(
        {login: loginData},
        {
          wait: true, 
          success: this.successCreate,
          error: this.errorCreate
        }
      ) 
    
    successCreate: (model, response, options)->
      $('.errors').remove()    
  
    errorCreate: (model, xhr, options)->
      $('.errors').remove()
      helper = new Helper()
      helper.dealErrors('.login', xhr)

    displayRegister: ->
      @$el.after(@userView.el)
      @userView.$el.slideDown()
