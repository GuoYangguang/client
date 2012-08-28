define ["jquery", "underscore", "backbone", "cs!workspace/model"], 
($, _, Backbone, Workspace)->
  class Workspaces extends Backbone.Collection
    
    model: Workspace
    
    url: ->
      "/workspaces" 
 
        
