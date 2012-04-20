define ->
  class AppRouter extends Backbone.Router 
    routes: {
      "": "showWorkspace" 
      "boards": "listBoards"
    
    }

    showWorkspace: -> 
      $("#result").text("workspace1 has been rendered with data")
    
    listBoards: ->
      $("#list-boards").html("<li>board1</li><li>board2</li>")
       
