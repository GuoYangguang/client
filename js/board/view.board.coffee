define [
  "jquery", 
  "backbone", 
  "cs!helper", 
  "cs!board/state/states", 
  "cs!board/state/view.states",
  "text!templates/board/board.html", 
  "text!templates/board/show.html" 
],($, Backbone, Helper, States, StatesView, boardHtml, showBoardHtml) ->

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
      $(this.el).find(".board").addClass("color-board").
        find("span.delete-board").show()
    
    hideMenu: ->
      $(this.el).find(".board").removeClass("color-board")
        .find("span.delete-board").hide()

    showBoard: ->
      this.model.fetch({wait: true, 
      success: this.successFetch, error: this.errorFetch})
    
    successFetch: (model, response)->
      $(".errors").remove()
      
      data = model.toJSON()
      directives = {"h3": "name", "h3@data-board": "id"}
      htmlWithData = $(showBoardHtml).render(data, directives)
      $("#boards").html(htmlWithData)
      
      workspaceId = $("#workspace-name").attr("data-workspace")
      states = new States([], {workspaceId: workspaceId , boardId: model.id})
      statesView = new StatesView({collection: states})
      statesView.fetchStates()

    errorFetch: (model, response)->
      $(".errors").remove()
      helper = new Helper()
      helper.dealErrors("#list-boards", response)
    
    confirm: ->
      val = confirm("Are you sure to delete it?")
      this.deleteBoard() if val

    deleteBoard: ->
      this.model.destroy({wait: true, 
      success: this.successDel, error: this.errorDel})

    successDel: (model, response)-> 
      $(".errors").remove()

    errorDel: (model, response)->
      $(".errors").remove()
      helper = new Helper()
      helper.dealErrors("#list-boards", response)      
   
    destroyCal: -> 
      this.remove()

    render: -> 
      data = this.model.toJSON()
      directives = {"span.board-name": "name"}
      htmlWithData = $(boardHtml).render(data, directives)
      this.$el.html(htmlWithData)
      this
