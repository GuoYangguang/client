define [
  'backbone',
  'jquery', 
  'cs!helper',
  'text!templates/user/register.html'
], (Backbone, $, Helper, registerHtml)->

  class UserView extends Backbone.View
   
    className: 'register'

    initialize: (options)->
      @$el.html(registerHtml)
      @model.bind('change', @changeCallback, @)

    events: {
      'click #register-btn2': 'createUser'
    }

    createUser: ->
      userData = {
        email: @$el.find('input[name="register-email"]').val(), 
        password: @$el.find('input[name="register-password"]').val(), 
        password_confirmation: @$el.find('input[name="register-confirmation"]').val()
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
      $('.errors').remove() 

    errorCreate: (model, xhr, options)->
      $('.errors').remove() 
      helper = new Helper()
      helper.dealErrors('.register', xhr)

    changeCallback: ->
      @model.unset('user', {silent: true})
      @$el.slideUp()
      @$el.find('p input').val('')

