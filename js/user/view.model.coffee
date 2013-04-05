define [
  'backbone',
  'jquery', 
  'cs!helper',
  'text!templates/user/user.html'
], (Backbone, $, Helper, userHtml)->

  class UserView extends Backbone.View
   
    id: 'user-view'

    initialize: (options)->
      @$el.html(userHtml)
      @listenTo(@model, 'change', @changeCallback)

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
        

