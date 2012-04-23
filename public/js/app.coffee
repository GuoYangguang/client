require ["jquery", "cs!router"], ($, AppRouter)->
  $(document).ready ->
    app = new AppRouter() 
    Backbone.history.start()
