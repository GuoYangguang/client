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
      "click #create-state": "createState" 
    
    }

    createState: ->
      value = $("#new-state").val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $("#errors").remove()
      
    errorCreate: (model, response)->
      helper = new Helper()
      helper.dealErrors("#states", response)
   
    appendState: (state)->
      stateView = new StateView({model: state})
      $(this.el).append(stateView.render().el)
    
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
      statesView = this
      this.collection.each (state)->
        stateView = new StateView({model: state})
        $(statesView.el).append(stateView.render().el)
      this
