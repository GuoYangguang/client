define ['backbone'], (Backbone)->
  
  class Router extends Backbone.Router
    
    routes: {
      '': 'test' 
    }

    test: ->
      console.log 'hello'
