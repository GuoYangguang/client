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

    initialize: ->
      this.collection.bind("reset", this.render, this)
      this.collection.bind("add", this.showBoard, this)
    
    events: {
      "click #create-board-btn": "createBoard",
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
      $(".errors").remove()   

    errorFetch: (collection, response) ->
      helper = new Helper()
      helper.dealErrors("#boards", response)

    render: ->
      this.$el.html(boardsHtml)
      #on page to active events
      $("#boards").html(this.el)
      listBoardsNode = this.$("#list-boards")
      this.collection.each (board)->
        boardView = new BoardView({model: board})
        listBoardsNode.append(boardView.render().el)
     
      #this view object's htmls always be refreshed
      this.delegateEvents()

      this

    showBoard: (board)->
      data = board.toJSON()
      directives = {"h3": "name", "h3@data-board": "id"}
      htmlWithData = $(showBoardHtml).render(data, directives)
      $("#boards").html(htmlWithData)
      
    createBoard: ->
      value = $('#new-board').val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $(".errors").remove() 
      workspaceId = $("#workspace-name").attr("data-workspace")
      states = new States([], {workspaceId: workspaceId , boardId: model.id})
      statesView = new StatesView({collection: states})
      statesView.render()

    errorCreate: (model, response)->
      helper = new Helper()        
      helper.dealErrors("#create-board", response)

    
