define ["jquery", "underscore", "backbone", "text!templates/board.html", 
"cs!helper", "text!templates/showBoard.html", "cs!board/state/collection", 
"cs!board/state/collection_view"], 
($, _, Backbone, boardHtml, Helper, showBoardHtml, States, StatesView) ->

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
      directives = {"h3": "name", "h3@data-board": "id"} 
      htmlWithData = $(showBoardHtml).render(data, directives)
      $("#boarddata").html(htmlWithData)

      workspaceId = $("#workspace").attr("data-workspace")
      boardId = $("#board").attr("data-board")
      states = new States([], {workspaceId: workspaceId , boardId: boardId})
      statesView = new StatesView({collection: states})
      statesView.fetchStates()
       
      $("#boarddata").append(statesView.el)

    errorFetch: (model, response)->
      helper = new Helper()
      helper.dealErrors("#boarddata", response)
   
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
      helper.dealErrors("#boarddata", response)      
   
    destroyCal: -> 
      this.remove()

    render: -> 
      data = this.model.toJSON()
      directives = {"span.boardName": "name"}
      htmlWithData = $(boardHtml).render(data, directives)
      $(this.el).html(htmlWithData).attr('data-board', this.model.id)
      this
