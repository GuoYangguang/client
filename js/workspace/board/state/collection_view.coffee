define ["jquery", 
        "underscore", 
        "backbone", 
        "cs!workspace/board/state/model_view",
        "cs!workspace/board/state/story/collection",
        "cs!workspace/board/state/story/collection_view",
        "text!templates/workspace/board/state/states.html",
        "cs!helper"
       ], 
($, _, Backbone, StateView, Stories, StoriesView, statesHtml, Helper) ->

  class StatesView extends Backbone.View
    tagName: "div"
    id: "states"

    initialize: ->
      this.collection.bind("add", this.appendState, this)
      this.collection.bind("reset", this.render, this)
    
    events: {
      "click #create-state-btn": "createState" 
    
    }

    createState: ->
      value = $("#new-state").val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $("#errors").remove()
      
    errorCreate: (model, response)->
      helper = new Helper()
      helper.dealErrors("#create-state", response)
   
    appendState: (state)->
      stateView = new StateView({model: state})
      $("#states-stories").append(stateView.render().el)
    
    fetchStates:  ->
      this.collection.fetch(
        { 
         wait: true, 
         success: this.successFetch, 
         error: this.errorFetch
        }
      )

    successFetch: (collection, response)->
      $("#errors").remove()

    errorFetch: (collection, response)->
      helper = new Helper()
      helper.dealErrors("#board", response)

    render: ->
      $(this.el).html(statesHtml)
      appendNode = $(this.el).find("#states-stories")
      workspaceId = $("#workspace").attr("data-workspace")
      boardId = $("#board h3").attr("data-board")
      this.collection.each (state)->
        stateView = new StateView({model: state})
        appendNode.append(stateView.render().el)

        stories = new Stories(
          [], 
          {workspaceId: workspaceId, boardId: boardId, stateId: state.id}
        )
        storiesView = new StoriesView({collection: stories})
        storiesView.fetchStories()

      $("#board-data").append(this.el)
      this
    
