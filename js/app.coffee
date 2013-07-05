require ['jquery', 
         'backbone',
         'cs!router'
        ],
($, Backbone, Router) ->

  $(document).ready ->
    window.Clienting = {}
    window.Clienting.router = new Router()
    Backbone.history.start({pushState: true, root: '/w/'})
       
    
