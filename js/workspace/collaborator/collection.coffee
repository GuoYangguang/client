define ["underscore", "backbone", "cs!workspace/collaborator/model"],
(_, Backbone, Collaborator)->
 
  class Collaborators extends Backbone.Collection

    model: Collaborator
    
    initialize: (models, options)->
      @workspaceId = options.workspaceId if options.workspaceId

    url: ->
      "/workspaces/" + @workspaceId + "/collaborators"
