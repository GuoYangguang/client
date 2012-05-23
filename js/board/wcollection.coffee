define ["jquery", "underscore", "backbone", "cs!board/wmodel"], 
($, _, Backbone, Workspace)->
  class Workspaces extends Backbone.Collection
    
    model: Workspace
    
    url: "/workspaces" 
 
        
