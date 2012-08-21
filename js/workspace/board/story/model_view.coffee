define [
        "jquery",
        "underscore",
        "backbone",
        "text!templates/workspace/board/story/story.html",
        "cs!helper"
       ],
($, _, Backbone, storyHtml, Helper)->
  
  class StoryView extends Backbone.View
    tagName: "li"

    render: ->
      data = this.model.toJSON()
      directives = {"span": "name"}
      htmlWithData = $(storyHtml).render(data, redirectives)
      $(this.el).html(htmlWithData)
      this
