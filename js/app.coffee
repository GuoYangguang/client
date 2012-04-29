require ["jquery", "underscore", "backbone", "cs!router"], ($, _, Backbone, Router) ->
  
  $(document).ready ->
    router = new Router()
    Backbone.history.start()
    
