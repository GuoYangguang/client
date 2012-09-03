define [
        "jquery",
        "underscore",
        "backbone",
        "cs!workspace/board/story/model_view",
        "cs!workspace/collaborator/collection",
        "text!templates/workspace/board/story/stories.html",
        "text!templates/workspace/board/story/dialog.html",
        "cs!helper"
       ],
($, _, Backbone, StoryView, Collaborators, storiesHtml, dialogHtml, Helper)->
  
  class StoriesView extends Backbone.View

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
      $(".errors").remove()

    errorFetch: (collection, response)->
      helper = new Helper()
      helper.dealErrors("#states", response)

    render: ->
      appendNode = $(this.el).html(storiesHtml).find("ul")
      this.collection.each (story)->
        storyView = new StoryView({model: story}) 
        appendNode.append(storyView.render().el)
      $("#state_#{this.collection.stateId}").append(this.el)
      this

    newStory: ->
      storiesView = this

      cols = Collaborators.collaborators
      data = {performers: cols.pluck("first")}
      directives = {
        "li": {
          "performer<-performers": {
            "span.performer": "performer"
          }  
        } 
      }
      htmlWithData = $(dialogHtml).render(data, directives)
      $("body").append(htmlWithData)

      $(".sedate").datepicker(
        {
         dateFormat: 'yy-mm-dd',
         showOn: "button",
         buttonImageOnly: true,
         buttonImage: "/img/calendar.gif"
        }
      )

      $("#dialog").dialog(
        {
         modal: true, 
         width: 600,
         title: "create a new story",
         buttons: [ 
           { 
             text: "Create",
             click: -> 
               storiesView.createStory()
           }
         ],
         close: ->
           $(".sedate").datepicker("disable")
           $(".sedate").datepicker("destroy")
           $(this).dialog("destroy") 
           $("#dialog").remove()
        }
      )

    createStory: ->
      #console.log this.collection.stateId
