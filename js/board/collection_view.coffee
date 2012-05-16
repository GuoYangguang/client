define ["jquery", "underscore", "backbone", "cs!board/model_view", 
"text!templates/boards.html", "cs!helper"], 
($, _, Backbone, BoardView, boardsHtml, Helper) ->

  class BoardsView extends Backbone.View
    tagName: "div"
    
    initialize: ->
      $(this.el).html(boardsHtml)
      this.collection.bind("reset", this.render, this)
      this.collection.bind("add", this.appendBoard, this)
    
    events: {
      "click #createBoard": "createBoard"
      
    }

    fetchBoards: ->
      this.collection.fetch({wait: true, success: this.successFetch, 
      error: this.errorFetch})
        
    successFetch: (collection, response) ->
      $("#errors").remove()   

    errorFetch: (collection, response) ->
      helper = new Helper()
      helper.dealErrors("#boards", response)

    render: ->
      this.listBoards()
      $("#boards").html(this.el)
      this

    listBoards: ->
      boardsView = this
      this.collection.each (board)->
        boardsView.appendBoard board
    
    appendBoard: (board)->
      boardView = new BoardView({model: board})
      $(this.el).find("ul#listBoards").append(boardView.render().el)

    createBoard: ->
      value = $('#newBoard').val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $("#errors").remove()

    errorCreate: (model, response)->
      helper = new Helper()        
      helper.dealErrors("#boards p", response)

    
