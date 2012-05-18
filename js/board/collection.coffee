define ["jquery", "underscore", "backbone", "cs!board/model"], 
($, _, Backbone, Board)->
  class Boards extends Backbone.Collection
    model: Board
    
    url: ->
      workspace_id = $("#fetchBoards").attr("data-workspace")
      "/workspaces/" + workspace_id + "/boards"  

    comparator: (board)->
      board.get("created_at")
      
