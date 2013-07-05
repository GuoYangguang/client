define ["underscore", 
        "backbone",
        "cs!board/state/state"
       ], 
(_, Backbone, State)->

  class States extends Backbone.Collection
    
    initialize: (models, options)->
      @workspaceId = options.workspaceId if options.workspaceId
      @boardId = options.boardId if options.boardId 
     
    model: State

    url: -> 
      "/boards/#{@boardId}/states"

    comparator: (state)->
      state.get("created_at")
