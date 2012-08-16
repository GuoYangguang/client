define [
        "jquery",
        "underscore",
        "backbone",
        "cs!workspace/board/state/story/model_view",
        "text!templates/workspace/board/state/story/stories.html",
        "cs!helper"
       ],
($, _, Backbone, StoryView, storiesHtml, Helper)->
  
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
      alert "i am new story"
