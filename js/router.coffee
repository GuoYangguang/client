define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  class Router extends Backbone.Router
    routes: {
      "": "showWorkspace",
      "boards": "listBoards"
    }

    showWorkspace: ->
      $("#workspace").text("workspace1 has been updated with data")
    
    listBoards: ->
      $("#boards").after("<ul><li>board1</li></ul>")      
