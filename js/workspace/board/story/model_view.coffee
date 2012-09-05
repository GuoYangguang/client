define [
        "jquery",
        "underscore",
        "backbone",
        "text!templates/workspace/board/story/story.html",
        "text!templates/workspace/board/story/show_story.html",
        "cs!helper"
       ],
($, _, Backbone, storyHtml, showStoryHtml, Helper)->
  
  class StoryView extends Backbone.View
    tagName: "li"
    className: "story"
    
    events: {
      "click.story": "showStory"
    }
    
    showStory: ->
      data = this.model.toJSON() 
      directives = {
        ".storyName": "name", 
        "ul.performers li": {
          "performer<-users": {
            "span": "performer.first"
          }  
        },
        ".startDate": "start",
        ".endDate": "end"
      }
      htmlWithData = $(showStoryHtml).render(data, directives)
      $("body").append(htmlWithData)
      $("#show-story").dialog(
        {
         modal: true,
         width: 600,
         close: ->
           $("#show-story").dialog("destroy") 
           $("#show-story").remove() 
        }
      )

    render: ->
      data = this.model.toJSON()
      directives = {"span": "name"}
      htmlWithData = $(storyHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
