define [
  'backbone',
  'jquery',
  'text!templates/session/session.html',
  'cs!user/model',
  'cs!user/model_view',
  'cs!helper'
], (Backbone, $, sessionHtml, User, UserView, Helper)->
  
  class SessionView extends Backbone.View
    
    className: 'session-view'

    initialize: (options)->
      @$el.html sessionHtml
      @model.bind('change', @changeCallback, @)

    events: {
      'click #user-view-btn1': 'userView', 
      'click #session-view-btn': 'createSession'
    }
    
    createSession: ->
      email = @$el.find('input[name="session-view-email"]').val()
      password = @$el.find('input[name="session-view-password"]').val()
      sessionData = {
        email: email,
        password: password
      }
      @model.save(
        {session: sessionData},
        {
          wait: true, 
          success: this.successCreate,
          error: this.errorCreate
        }
      ) 
    
    successCreate: (model, response, options)->
      $('.errors').remove()    
      window.router.navigate '', {trigger: true}

    errorCreate: (model, xhr, options)->
      $('.errors').remove()
      helper = new Helper()
      helper.dealErrors('.session-view', xhr)
    
    changeCallback: ->
      @model.clear {silent: true}
      @remove()

    userView: ->
      user = new User()
      userView = new UserView(model: user)
      @$el.after(userView.el)
      userView.$el.slideDown()
