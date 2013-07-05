define [
  'backbone',
  'jquery',
  'underscore',
  'text!templates/session/new.html',
  'cs!helper'
], (Backbone, $, _, newHtml, Helper)->
  
  class SessionView extends Backbone.View
    
    id: 'session-view'

    initialize: (options)->
      @$el.html newHtml
      @listenTo(@model, 'change', @changeCallback)
      _.bindAll(@, 'successCreate', 'errorCreate')

    events: {
      'click #user-view-btn1': 'signup', 
      'click #session-view-btn': 'createSession'
    }

    signup: ->
      window.Clienting.router.navigate('/signup', {trigger: true})

    createSession: ->
      email = @$el.find('input[name="email"]').val()
      password = @$el.find('input[name="password"]').val()
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
      $('#session-view-errors').remove()    
      window.Clienting.router.navigate '', {trigger: true}

    errorCreate: (model, xhr, options)->
      $('#session-view-errors').remove()
      helper = new Helper()
      helper.dealErrors('#session-view', 'session-view-errors', xhr)
    
    changeCallback: ->
      @model.clear {silent: true}

