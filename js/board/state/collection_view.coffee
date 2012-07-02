define ["jquery", 
        "underscore", 
        "backbone", 
        "cs!board/state/model_view",
        "text!templates/state/states.html",
        "cs!helper"
       ], 
($, _, Backbone, StateView, statesHtml, Helper) ->

  class StatesView extends Backbone.View
    tagName: "div"

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

    errorFetch: (collection, response)->

    render: ->
      $(this.el).html(statesHtml)
      appendNode = $(this.el).find("#states-stories")
      this.collection.each (state)->
        stateView = new StateView({model: state})
        appendNode.append(stateView.render().el)
      $("#board-data").append(this.el)
      this
    
