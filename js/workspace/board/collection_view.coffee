define ["jquery", 
        "underscore", 
        "backbone", 
        "cs!workspace/board/model_view", 
        "text!templates/workspace/board/boards.html", 
        "cs!helper"
       ], 
($, _, Backbone, BoardView, boardsHtml, Helper) ->

  class BoardsView extends Backbone.View
    tagName: "div"

    initialize: ->
      this.collection.bind("reset", this.render, this)
      this.collection.bind("add", this.prependBoard, this)
    
    events: {
      "click #create-board-btn": "createBoard"
      "click #boards-page": "fetchBoards" 
    }

    fetchBoards: ->
      this.collection.fetch(
        {
         wait: true, 
         data: {page: this.collection.currentPage},
         success: this.successFetch, 
         error: this.errorFetch
        }
      )
        
    successFetch: (collection, response) ->
      collection.currentPage++
      $("#errors").remove()   

    errorFetch: (collection, response) ->
      helper = new Helper()
      helper.dealErrors("#board-data", response)

    render: ->
      if $("ul#list-boards").length is 0
        listBoardsNode = $(this.el).html(boardsHtml).find("#list-boards")
        this.collection.each (board)->
          boardView = new BoardView({model: board})
          listBoardsNode.append(boardView.render().el)
      else
        this.collection.each (board)->
          boardView = new BoardView({model: board})
          $("ul#list-boards").append(boardView.render().el)
      this

    prependBoard: (board)->
      boardView = new BoardView({model: board})
      $("ul#list-boards").prepend(boardView.render().el)

    createBoard: ->
      value = $('#new-board').val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $("#errors").remove() 

    errorCreate: (model, response)->
      helper = new Helper()        
      helper.dealErrors("#create-board", response)

    
