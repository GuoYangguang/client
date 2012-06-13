define ["jquery", 
        "underscore", 
        "backbone", 
        "text!board/state/states.html"
       ], 
($, _, Backbone, statesHtml) ->

  class StatesView extends Backbone.View
    tagName: "div"
    
    initialize: ->
      this.collection.bind("add", this.appendState, this)

    createState: ->
      value = $("#new-state").val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
    
    appendState: (state)->

    render: ->
      this.collection.each (state)->

