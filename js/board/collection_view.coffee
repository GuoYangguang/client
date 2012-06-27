define ["jquery", "underscore", "backbone", "cs!board/model_view", 
"text!templates/boards.html", "cs!helper"], 
($, _, Backbone, BoardView, boardsHtml, Helper) ->

  class BoardsView extends Backbone.View
    tagName: "div"

    initialize: ->
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
      helper.dealErrors("#fetchBoards", response)

    render: ->
      $(this.el).html(boardsHtml)
      boardsView = this
      this.collection.each (board)->
        boardView = new BoardView({model: board})
        $(boardsView.el).find("ul#listBoards").append(boardView.render().el)
      $("#boarddata").html(this.el)
      this

    appendBoard: (board)->
      boardView = new BoardView({model: board})
      $("ul#listBoards").append(boardView.render().el)

    createBoard: ->
      value = $('#newBoard').val()
      this.collection.create({name: value}, 
        {wait: true, success: this.successCreate, error: this.errorCreate})
    
    successCreate: (model, response)->
      $("#errors").remove() 

    errorCreate: (model, response)->
      helper = new Helper()        
      helper.dealErrors("#boarddata p", response)

    
