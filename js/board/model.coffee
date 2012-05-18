define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  class Board extends Backbone.Model
    
    urlRoot: ->
      workspace_id = $("#fetchBoards").attr("data-workspace")
      "/workspaces/" + workspace_id + "/boards"
    
