define ["jquery", 
        "underscore", 
        "backbone", 
        "cs!helper",
        "cs!workspace/board/model_view", 
        "cs!workspace/board/state/collection", 
        "cs!workspace/board/state/collection_view",
        "text!templates/workspace/board/show.html",
        "text!templates/workspace/board/boards.html" 
       ], 
($, _, Backbone, Helper, BoardView, States, StatesView, showBoardHtml, boardsHtml) ->

  class BoardsView extends Backbone.View
    tagName: "div"

    initialize: ->
      this.collection.bind("reset", this.render, this)
      this.collection.bind("add", this.showBoard, this)
    
    events: {
      "click #create-board-btn": "createBoard"
      "click #more-boards": "fetchBoards" 
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
      listBoardsNode = $(this.el).html(boardsHtml).find("#list-boards")
      this.collection.each (board)->
        boardView = new BoardView({model: board})
        listBoardsNode.append(boardView.render().el)
      $("#board-data").html(this.el)
      this

    showBoard: (board)->
      data = board.toJSON()
      directives = {"h3": "name", "h3@data-board": "id"}
      htmlWithData = $(showBoardHtml).render(data, directives)
      $("#board-data").html(htmlWithData)
      
      workspaceId = $("#workspace").attr("data-workspace")
      states = new States([], {workspaceId: workspaceId , boardId: board.id})
      statesView = new StatesView({collection: states})
      statesView.fetchStates()

    createBoard: ->
      value = $('#new-board').val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $("#errors").remove() 

    errorCreate: (model, response)->
      helper = new Helper()        
      helper.dealErrors("#create-board", response)

    
