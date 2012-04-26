define ["underscore", "backbone"], (_, Backbone)->
  class Boards extends Backbone.Collection
    
    url: "/boards"
