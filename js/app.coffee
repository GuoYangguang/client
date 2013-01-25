require ['jquery', 
         'backbone',
         'cs!router'
        ],
($, Backbone, Router) ->

  $(document).ready ->
    new Router()
    Backbone.history.start({pushState: true, root: '/w/'})
       
    
