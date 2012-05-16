define ["jquery", "underscore", "backbone", "text!templates/board.html"], 
($, _, Backbone, boardHtml) ->
  class BoardView extends Backbone.View 
    tagName: "li"
    
    template: $(boardHtml)
     
    events: {
      "click .board": "showBoard"
    }

    showBoard: ->
      console.log "clicking..."
      
    editBoard: ->
      console.log "dbclick"

    render: -> 
      data = this.model.toJSON()
      directives = {"span": "name"}
      htmlWithData = this.template.render(data, directives)
      $(this.el).html(htmlWithData)
      this
