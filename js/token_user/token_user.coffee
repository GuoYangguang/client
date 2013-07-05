define ['backbone'], (Backbone)->
  
  class TokenUser extends Backbone.Model
    
    urlRoot: '/api/v1/signin'
