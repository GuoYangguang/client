define ['backbone',
        'text!templates/user/register.html'
], (Backbone, registerHtml)->

  class UserView extends Backbone.View

    initialize: (options)->
      @$el.html(registerHtml)

    render: ->
      $(registerHtml).render()
