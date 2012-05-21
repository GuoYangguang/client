define ["jquery", "underscore", "backbone", "text!templates/board.html", 
"cs!helper"], ($, _, Backbone, boardHtml, Helper) ->

  class BoardView extends Backbone.View 
    tagName: "li"
    
    template: $(boardHtml)
         
    events: {
      "mouseover .board": "showMenu",
      "mouseout .board": "hideMenu",
      "click .boardName": "showBoard",
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
      this.deleteBoard()  if v

    deleteBoard: ->
      this.model.destroy({wait: true, 
      success: this.successDel, error: this.errorDel})

    successDel: (model, response)-> 
      $("#errors").remove()

    errorDel: (model, response)->
      helper = new Helper()  
      helper.dealErrors("#boards", response)      

    render: -> 
      data = this.model.toJSON()
      directives = {"span.boardName": "name"}
      htmlWithData = this.template.render(data, directives)
      $(this.el).html(htmlWithData)
      this
