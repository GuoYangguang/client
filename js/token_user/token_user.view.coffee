define [
  'backbone',
  'jquery',
  'underscore',
  'text!templates/token_user/new.html',
  'cs!helper'
], (Backbone, $, _, newHtml, Helper)->
  
  class TokenUserView extends Backbone.View
    
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
    

    id: 'user-view'

    initialize: (options)->
      @$el.html(newHtml)
      @listenTo(@model, 'change', @changeCallback)
      console.log @

    events: {
      'click #user-view-btn2': 'createUser'
    }

    createUser: ->
      userData = {
        email: @$el.find('input[name="email"]').val(), 
        name: @$el.find('input[name="name"]').val(),
        password: @$el.find('input[name="password"]').val(), 
        password_confirmation: @$el.find('input[name="confirmation"]').val()
      }

      @model.save(
        {user: userData},
        { 
          wait: true, 
          success: @successCreate, 
          error: @errorCreate
        }
      )
    
    successCreate: (model, response, options)->
      $('#user-view-errors').remove() 
      window.Clienting.router.navigate('/login', {trigger: true})

    errorCreate: (model, xhr, options)->
      $('#user-view-errors').remove() 
      helper = new Helper()
      helper.dealErrors('#user-view', 'user-view-errors', xhr)

    changeCallback: ->
      @model.clear(silent: true)
