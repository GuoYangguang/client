define ['backbone', 
        'user/collection', 
        'text!templates/user/register'
], (Backbone, Users)->
  
  class UsersView extends Backbone.View
    
    render: ->
