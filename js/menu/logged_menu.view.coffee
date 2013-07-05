define [
  'backbone',
  'text!templates/menu/logged.html'
], (Backbone, loggedMenuHtml) ->
  
  class LoggedMenuView extends Backbone.View 

    initialize: (options)->
      @$el.html(loggedMenuHtml)
      @listenTo(@model, 'destroy', @destroyCal)
      
    events: {
      'click .logged-menu-boards': 'navBoards'       
      'click .logged-menu-logout': 'deleteSession'
    }
 
    navBoards: ->
      window.Clienting.router.navigate '', {trigger: true}

    deleteSession: ->
      @model.destroy wait: true, 
        success: @successDestroy, error: @errorDestroy

    successDestroy: (model, response, options)->

    errorDestroy: (model, xhr, options) ->

    destroyCal: ->
      @off()
      @remove()
