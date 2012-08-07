define ["jquery", "underscore", "backbone", "cs!workspace/wmodel"], 
($, _, Backbone, Workspace)->
  class Workspaces extends Backbone.Collection
    
    model: Workspace
    
    url: "/workspaces" 
 
        
