define [
  "jquery", 
  "backbone", 
  "cs!helper", 
  "cs!board/state/states", 
  "cs!board/state/view.states",
  "text!templates/board/board.html", 
  "text!templates/board/show.html" 
],($, Backbone, Helper, States, StatesView, boardHtml, showHtml) ->

  class BoardView extends Backbone.View 

    initialize: (options)->
      @listenTo(@model, "destroy", @destroyCal)
      @$el.html(boardHtml)

    tagName: "li"
    className: 'board-view'

    events: {
      "mouseover": "showMenu",
      "mouseout": "hideMenu",
      "click .board-view-name": "showBoard",
      "click .board-view-del": "confirm"
    }

    showMenu: ->
      @$.el.addClass("color-board").
        find("span.board-view-del").show()
    
    hideMenu: ->
      @$.el.removeClass("color-board")
        .find("span.board-view-del").hide()

    showBoard: ->
      @model.fetch({wait: true, 
      success: @successFetch, error: @errorFetch})
    
    successFetch: (model, response, options)->
      $(".errors").remove()
      
      data = model.toJSON()
      directives = {"h3": "name", "h3@data-board": "id"}
      htmlWithData = $(showHtml).render(data, directives)
      $("#boards").html(htmlWithData)
      
      workspaceId = $("#workspace-name").attr("data-workspace")
      states = new States([], {workspaceId: workspaceId , boardId: model.id})
      statesView = new StatesView({collection: states})
      statesView.fetchStates()

    errorFetch: (model, xrh, options)->
      $(".errors").remove()
      helper = new Helper()
      helper.dealErrors("#list-boards", response)
    
    confirm: ->
      val = confirm("Are you sure to delete it?")
      @deleteBoard() if val

    deleteBoard: ->
      @model.destroy({wait: true, 
      success: @successDel, error: @errorDel})

    successDel: (model, response)-> 
      $(".errors").remove()

    errorDel: (model, response)->
      $(".errors").remove()
      helper = new Helper()
      helper.dealErrors("#list-boards", response)      
   
    destroyCal: -> 
      @remove()

    render: -> 
      data = this.model.toJSON()
      directives = {"span.board-view-name": "name"}
      @$el.render(data, directives)
      this
