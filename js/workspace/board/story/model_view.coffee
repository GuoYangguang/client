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
    
    initialize: ->
      this.model.bind("destroy", this.removeStory, this)
      this.$el.draggable(
        {
         distance: 200,
         cursor: "crosshair",
         revert: "invalid",
         stack: this.$el
        }
      )

    events: {
      "click .story-name": "showStory",
      "mouseover p": "showMenu", 
      "mouseout p": "hideMenu",
      "click .delete-story": "confirmDel",
      "dragstop": "dragStop"
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
         width: 400,
         close: ->
           $("#show-story").dialog("destroy") 
           $("#show-story").remove() 
        }
      )
    
    showMenu: ->
      this.$("span.delete-story").show()

    hideMenu: ->
      this.$("span.delete-story").hide()
    
    confirmDel: ->
      val = confirm("Are you sure to delete it?")
      this.deleteStory() if val
        

    deleteStory: ->
      this.model.destroy(
        {
         wait: true, 
         success: this.sucDestroy,
         error: this.errorDestroy
        }
      )
    
    sucDestroy: (model, response)->
      $(".errors").remove()

    errorDestroy: (model, response)->
      helper = new Helper()
      helper.dealErrors("#states", response)

    removeStory: ->
      this.remove()

    render: ->
      data = this.model.toJSON()
      directives = {"span.story-name": "name"}
      htmlWithData = $(storyHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this

    dragStop: ->
      console.log this
      
