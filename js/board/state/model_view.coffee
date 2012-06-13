define ["jquery", 
        "underscore", 
        "backbone", 
        "text!templates/state/state.html"
       ], 
($, _, Backbone, stateHtml) ->

  class StateView extends Backbone.View
    tagName: "div"
    
    render: ->
      data = this.model.toJSON()
      directives = {"span.state": "name"}
      htmlWithData = $(stateHtml).render(data, directives)
      $(this.el).html(htmlWithData)
      this
