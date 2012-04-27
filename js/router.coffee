define ["jquery", "underscore", "backbone", "text!../templates/boards.html", "cs!board/model"], 
($, _, Backbone, html, Board) ->
  class Router extends Backbone.Router
    routes: {
      "": "showWorkspace",
      "boards": "listBoards"
    }

    showWorkspace: ->
      $("#workspace").text("workspace1 has been updated with data")
    
    listBoards: ->
      board1 = new Board({name: 'gyg', age: "30"})
      board2 = new Board()
      console.log JSON.stringify board1
      console.log JSON.stringify board2
