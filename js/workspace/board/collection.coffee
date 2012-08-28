define ["jquery", "underscore", "backbone", "cs!workspace/board/model"], 
($, _, Backbone, Board)->

  class Boards extends Backbone.Collection
    model: Board
    
    initialize: (models, options)->
      @workspace_id = options.workspace_id if options.workspace_id
      @currentPage = 0 

    url: ->
      "/workspaces/" + @workspace_id + "/boards"  

      
