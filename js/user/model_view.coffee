define [
  'backbone',
  'jquery', 
  'cs!helper',
  'text!templates/user/user.html'
], (Backbone, $, Helper, userHtml)->

  class UserView extends Backbone.View
   
    className: 'user-view'

    initialize: (options)->
      @$el.html(userHtml)
      @model.bind('change', @changeCallback, @)

    events: {
      'click #user-view-btn2': 'createUser'
    }

    createUser: ->
      userData = {
        email: @$el.find('input[name="user-view-email"]').val(), 
        password: @$el.find('input[name="user-view-password"]').val(), 
        password_confirmation: @$el.find('input[name="user-view-confirmation"]').val()
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
      helper.dealErrors('.user-view', xhr)

    changeCallback: ->
      @model.clear({silent: true})
      userView = @
      @$el.slideUp 'slow', -> 
        userView.remove()
        

