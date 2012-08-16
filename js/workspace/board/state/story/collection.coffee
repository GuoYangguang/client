define [
        "underscore", 
        "backbone",
        "cs!workspace/board/state/story/model"
       ], 
(_, Backbone, Story)->
  
  class Stories extends Backbone.Collection
   
    initialize: (models, options)->
      @workspaceId = options.workspaceId if options.workspaceId      
      @boardId = options.boardId if options.boardId
      @stateId = options.stateId if options.stateId

    model: Story

    url: ->
      "/workspaces/#{@workspaceId}/boards/#{@boardId}/states/#{@stateId}/stories"


