define ["underscore", "backbone", "cs!board/model"], 
(_, Backbone, Board)->
  class Boards extends Backbone.Collection
    model: Board
    
    initialize: (models, options)->
      @workspace_id = options.workspace_id if options.workspace_id

    url: ->
      "/workspaces/" + @workspace_id + "/boards"  

    comparator: (board)->
      board.get("created_at")
      
