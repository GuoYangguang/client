define [
        "underscore", 
        "backbone",
        "cs!board/story/story"
       ], 
(_, Backbone, Story)->
  
  class Stories extends Backbone.Collection
   
    initialize: (models, options)->
      @workspaceId = options.workspaceId if options.workspaceId      
      @boardId = options.boardId if options.boardId
      @stateId = options.stateId if options.stateId

    model: Story

    url: ->
      "/boards/#{@boardId}/states/#{@stateId}/stories"


