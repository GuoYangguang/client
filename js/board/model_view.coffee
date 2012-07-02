define ["jquery", "underscore", "backbone", "text!templates/board.html", 
"cs!helper", "cs!board/state/collection", "text!templates/show_board.html" 
"cs!board/state/collection_view"],
($, _, Backbone, boardHtml, Helper, States, showBoardHtml, StatesView) ->

  class BoardView extends Backbone.View 
    tagName: "li"
    
    initialize: (options)->
      this.model.bind("destroy", this.destroyCal, this)

    events: {
      "mouseover .board": "showMenu",
      "mouseout .board": "hideMenu",
      "click .board-name": "showBoard",
      "click .delete-board": "confirm"
    }

    showMenu: ->
      $(this.el).find("div.board").addClass("color-board").
        find("span.delete-board").show()
    
    hideMenu: ->
      $(this.el).find("div.board").removeClass("color-board")
        .find("span.delete-board").hide()

    showBoard: ->
      this.model.fetch({wait: true, 
      success: this.successFetch, error: this.errorFetch})
    
    successFetch: (model, response)->
      $("#errors").remove()
      
      data = model.toJSON()
      directives = {"h3": "name", "h3@data-board": "id"}
      htmlWithData = $(showBoardHtml).render(data, directives)
      $("#board-data").html(htmlWithData)
      
      workspaceId = $("#workspace").attr("data-workspace")
      states = new States([], {workspaceId: workspaceId , boardId: model.id})
      statesView = new StatesView({collection: states})
      statesView.fetchStates()

    errorFetch: (model, response)->
      helper = new Helper()
      helper.dealErrors("#list-boards", response)
    
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
      helper.dealErrors("#list-boards", response)      
   
    destroyCal: -> 
      this.remove()

    render: -> 
      data = this.model.toJSON()
      directives = {"span.board-name": "name"}
      htmlWithData = $(boardHtml).render(data, directives)
      $(this.el).html(htmlWithData).attr('data-board', this.model.id)
      this
