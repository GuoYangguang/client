define ["jquery", "underscore", "backbone", "text!templates/board.html"], 
($, _, Backbone, boardHtml) ->
  class BoardView extends Backbone.View 
    tagName: "li"
    
    template: $(boardHtml)
     
    events: {
      "click .boardName": "showBoard",
      "mouseover .board": "showMenu",
      "mouseout .board": "hideMenu",
      "click .deleteBoard": "confirm"
    }

    showMenu: ->
      $(this.el).find("div.board").addClass("colorBoard").
        find("span.deleteBoard").show()
    
    hideMenu: ->
      $(this.el).find("div.board").removeClass("colorBoard")
        .find("span.deleteBoard").hide()
      
    showBoard: ->
      console.log "clicking..."
      
    confirm: ->
      v = confirm("Are you sure to delete it?")
      console.log v 
    
    deleteBoard: ->
      this.model.destroy({wait: true, success: this.successDel})

    successDel: -> 

    render: -> 
      data = this.model.toJSON()
      directives = {"span.boardName": "name"}
      htmlWithData = this.template.render(data, directives)
      $(this.el).html(htmlWithData)
      this
