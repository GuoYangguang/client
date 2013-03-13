define [
  "jquery", 
  "underscore",
  "backbone", 
  "cs!helper",
  "cs!board/view.board", 
  "text!templates/board/boards.html" 
], 
($, _, Backbone, Helper, BoardView, boardsHtml) ->

  class BoardsView extends Backbone.View

    initialize: ->
      @$el.html(boardsHtml)
      @listenTo(@collection, "reset", @render)
      @listenTo(@collection, "add", @showBoard)
      #_.bindAll(@, successFetch, errorFetch) 

    id: "boards-view"

    events: {
      "click #boards-view-btn": "createBoard",
      "click #boards-view-more": "fetchBoards" 
    }

    fetchBoards: ->
      @collection.fetch(
        {
         wait: true, 
         data: {page: @collection.currentPage},
         success: @successFetch, 
         error: @errorFetch
        }
      )
        
    successFetch: (collection, response, options) ->
      $("#boards-view-errors").remove()   

    errorFetch: (collection, xhr, options) ->
      $("#boards-view-errors").remove()   
      helper = new Helper()
      helper.dealErrors("#boards-view", "boards-view-errors" , xhr)

    render: ->
      @collection.currentPage++
      #on page to active events
      #$("#boards").html(this.el)
      #listBoardsNode = this.$("#list-boards")
      @boardViewArr = []
      @collection.each (board)->
        boardView = new BoardView({model: board})
        #listBoardsNode.append(boardView.render().el)
        boardView.render()
        @boardViewArr.push boardView
      for boardView in @boardViewArr 
        @$('ul').append(boardView.el)
     
      #this view object's htmls always be refreshed
      #this.delegateEvents()
      @ 

    createBoard: ->
      value = $('#new-board').val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $(".errors").remove() 

    errorCreate: (model, response)->
      $(".errors").remove()   
      helper = new Helper()        
      helper.dealErrors("#create-board", response)

    
