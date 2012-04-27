define ["jquery", "underscore", "backbone", "text!../templates/test.html"], 
($, _, Backbone, html) ->
  class Router extends Backbone.Router
    routes: {
      "": "showWorkspace",
      "boards": "listBoards"
    }

    jData: {who: "Gyg", where: "http://www.google.com"}
    showWorkspace: ->
      $("#result").text("workspace1 has been updated with data")
    
    listBoards: ->
      j = $(html).directives({"a": "who", "a@href": "where"})
      $("#list-boards").html(j.render({who: "Gyg", where: "http://www.google.com"}))
