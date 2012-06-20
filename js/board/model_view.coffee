define ["jquery", "underscore", "backbone", "text!templates/board.html", 
"cs!helper", "text!templates/showBoard.html"], 
($, _, Backbone, boardHtml, Helper, showBoardHtml) ->

  class BoardView extends Backbone.View 
    tagName: "li"
    
    initialize: (options)->
      this.model.bind("destroy", this.destroyCal, this)

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
      this.model.fetch({wait: true, 
      success: this.successFetch, error: this.errorFetch})
    
    successFetch: (model, response)->
      $("#errors").remove()
      data = model.toJSON()
      directives = {"h3": "name"} 
      htmlWithData = $(showBoardHtml).render(data, directives)
      $("#boards").html(htmlWithData)

    errorFetch: (model, response)->
      helper = new Helper()
      helper.dealErrors("#boards", response)
   
    confirm: ->
      val = confirm("Are you sure to delete it?")
      this.deleteBoard() if val

    deleteBoard: ->
      this.model.destroy({wait: true, 
      success: this.successDel, error: this.errorDel})

    successDel: (model, response)-> 
      $("#errors").remove()

    errorDel: (model, response)->
      helper = new Helper()  
      helper.dealErrors("#boards", response)      
   
    destroyCal: -> 
      this.remove()

    render: -> 
      data = this.model.toJSON()
      directives = {"span.boardName": "name"}
      htmlWithData = $(boardHtml).render(data, directives)
      $(this.el).html(htmlWithData).attr('data-board', this.model.id)
      this
