define ['backbone', 'cs!user/model'], (Backbone, User)->
  
  class Users extends Backbone.Collection
    
    model: User

    url: ->
      '/users'      
