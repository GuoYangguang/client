define ["underscore", "backbone", "cs!board/model"], (_, Backbone, Board)->
  class Boards extends Backbone.Collection
    model: Board

    url: "/boards"
