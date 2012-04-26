define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  class Router extends Backbone.Router
    routes: {
      "": "showWorkspace",
      "boards": "listBoards"
    }

    showWorkspace: ->
      $("#result").text("workspace1 has been updated with data")
    
    listBoards: ->
      
