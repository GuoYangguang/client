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
    tagName: "div"
    className: "stories"

    initialize: ->
      this.collection.bind("reset", this.render, this) 
      this.collection.bind("add", this.prependStory, this)
      this.$el.droppable(
        {
         drop: this.stateStory 
        }
      )

    events: {
      "click p.new-story": "newStory"
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
      if cols.isEmpty()
        alert "No collaborators in the workspace!"
      else
        data = {collaborators: cols.toJSON()}
        directives = {
          "li": {
            "collaborator<-collaborators": {
              "span.collaborator": "collaborator.first",
              "span input@data-user": "collaborator.id"
            }  
          } 
        }
        htmlWithData = $(dialogHtml).render(data, directives)
        $("body").append(htmlWithData)

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
           open: ->
             $(".sedate").datepicker(
               {
                dateFormat: 'yy-mm-dd',
                showOn: "button",
                buttonImageOnly: true,
                buttonImage: "/img/calendar.gif"
               }
             )     
           , 
           close: ->
             StoriesView.destroyDialog()
          }
        )

    createStory: ->
      performers = new Array()
      $(".select-collaborator:checked").each ->
        performers.push($(this).attr("data-user"))

      this.collection.create(
        {
         story: {
           name: $("#story-name").val(),
           start: $("#start-date").val(),
           end: $("#end-date").val()
         }, 
         users: performers 
        },
        {
         wait: true,
         success: this.successCreate, 
         error: this.errorCreate
        }
      )
    
    prependStory: (story)->
      storyView = new StoryView({model: story}) 
      this.$("ul").prepend(storyView.render().el)

    successCreate: (model, response)->
      $(".errors").remove()
      StoriesView.destroyDialog()
      

    errorCreate: (model, response)->
      helper = new Helper()
      helper.dealErrors("#dialog", response)
    
    stateStory: ->
      console.log(this.collection)

    @destroyDialog: ->
      $(".sedate").datepicker("disable")
      $(".sedate").datepicker("destroy")
      $("#dialog").dialog("destroy")
      $("#dialog").remove()
