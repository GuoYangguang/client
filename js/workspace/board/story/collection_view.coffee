define [
        "jquery",
        "underscore",
        "backbone",
        "cs!workspace/board/story/model_view",
        "text!templates/workspace/board/story/stories.html",
        "text!templates/workspace/board/story/dialog.html",
        "cs!helper"
       ],
($, _, Backbone, StoryView, storiesHtml, dialogHtml, Helper)->
  
  class StoriesView extends Backbone.View
    tagName: "div"

    initialize: ->
      this.collection.bind("reset", this.render, this) 

    events: {
      "click.new-story": "newStory"
    }
    
    fetchStories: ->
      this.collection.fetch(
        {wait: true, success: this.successFetch, error: this.errorFetch}
      ) 
    
    successFetch: (collection, response)->
      $("#errors").remove()

    errorFetch: (collection, response)->
      helper = new Helper()
      helper.dealErrors("#states", response)

    render: ->
      appendNode = $(this.el).html(storiesHtml).find("ul")
      this.collection.each (story)->
        storyView = new StoryView({model: story}) 
        appendNode.append(storyView.render().el)
      this

    newStory: ->
      $("body").append(dialogHtml).find("#dialog").dialog(
        {
         autoOpen: false,
         modal: true, 
         width: 600,
         title: "create a new story"
        }
      )
      $("#dialog").dialog("option", "buttons", [ 
         { 
           text: "Create",
           click: -> 
             $(this).dialog("destroy") 
             $("#dialog").remove()
         }
        ]
      )

      $("#dialog").dialog('open')  
      

      #$(".sedate").datepicker(
      #  {
      #   dateFormat: 'yy-mm-dd',
      #   showOn: "button",
      #   buttonImageOnly: true,
      #   buttonImage: "/img/calendar.gif"
      #  }
      #)
    createStory: ->
      console.log this
