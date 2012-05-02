define ["underscore", "backbone"], (_, Backbone) ->
  class Board extends Backbone.Model
    urlRoot: (workspace_id) ->"/workspaces/" + "#{workspace_id}" + "/boards"
