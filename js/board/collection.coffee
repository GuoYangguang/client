define ["underscore", "backbone", "cs!board/model"], (_, Backbone, Board)->
  class Boards extends Backbone.Collection
    model: Board

    url: "/workspaces/" + @workspace_id + "/boards"

    initialize: (options)->
      @workspace_id = options.workspace_id if options.workspace_id
      
      
