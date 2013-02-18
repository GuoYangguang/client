require ['jquery', 
         'backbone',
         'cs!router'
        ],
($, Backbone, Router) ->

  $(document).ready ->
    router = new Router()
    Backbone.history.start({pushState: true, root: '/w/'})
       
    
