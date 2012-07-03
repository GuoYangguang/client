define ["jquery", 
        "underscore", 
        "backbone", 
        "text!templates/state/state.html",
        "cs!helper"
       ], 
($, _, Backbone, stateHtml, Helper) ->

  class StateView extends Backbone.View
    tagName: "div"
    className: "state-stories"
    
    initialize: ->
      this.model.bind("destroy", this.destroyCal, this)

    events: {
      "click .delete-state": "confirm"
    
    }

    confirm: ->
      val = confirm("Are you sure to delete it?")
      this.deleteState() if val
    
    deleteState: ->
      this.model.destroy(
        {wait: true, success: this.successDel, error: this.errorDel}
      )
    
    successDel: (model, response)->
      $("#errors").remove()

    errorDel: (model, response)->
      helper = new Helper()
      helper.dealErrors("#states-stories", response)

    destroyCal: ->
      this.remove() 

    render: ->
      data = this.model.toJSON()
      directives = {"span.state": "name"}
      htmlWithData = $(stateHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
