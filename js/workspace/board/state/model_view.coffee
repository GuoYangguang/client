define ["jquery", 
        "underscore", 
        "backbone", 
        "text!templates/workspace/board/state/state.html",
        "text!templates/workspace/board/state/edit.html",
        "cs!helper"
       ], 
($, _, Backbone, stateHtml, editHtml, Helper) ->

  class StateView extends Backbone.View
    tagName: "li"
    className: "state-stories"
    
    initialize: ->
      this.model.bind("destroy", this.destroyCal, this)
      this.model.bind("change", this.changeCal, this)

    events: {
      "click .delete-state": "confirm", 
      "dblclick .state": "editState",
      "submit .state form": "updateState"
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
      helper.dealErrors("#states", response)

    destroyCal: ->
      this.remove() 
    
    editState: ->
      node = $(this.el).find(".state")
      val = node.text()
      node.html(editHtml)
      node.find("input").val(val)
    
    updateState: ->
      val = $(this.el).find(".state input").val()
      this.model.save(
        {name: val}, 
        {wait:true, success: this.successUpd, error: this.errorUpd}
      )
    
    successUpd: (model, response)->
      $("#errors").remove()

    errorUpd: (model, response)->
      helper = new Helper()
      helper.dealErrors("#states", response)
    
    changeCal: ->
      name = this.model.get("name")
      $(this.el).find(".state").html(name)

    render: ->
      data = this.model.toJSON()
      directives = {"span.state": "name"}
      htmlWithData = $(stateHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
