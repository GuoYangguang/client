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
    className: "story"
    
    events: {
      "click.story": "showStory"
    }
    

    showStory: ->
      alert "hello"

    render: ->
      data = this.model.toJSON()
      directives = {"span": "name"}
      htmlWithData = $(storyHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
