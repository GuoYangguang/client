define ["jquery", "underscore", "backbone", "cs!board/model_view", 
"text!templates/boards.html"], ($, _, Backbone, BoardView, html) ->

  class BoardsView extends Backbone.View
    tagName: "div"
    
    initialize: ->
      $(this.el).append(html)
      this.collection.bind("reset", this.render, this)
      this.collection.bind("add", this.appendBoard, this)
    
    events: {
      'click #createBoard': 'createBoard' 
    
    }

    listBoards: ->
      boardsView = this
      this.collection.each (board)->
        boardsView.appendBoard board

    render: ->
      this.listBoards()
      $("#boards").after(this.el)
      this
    
    createBoard: ->
      value = $('#newBoard').val()
      this.collection.create({name: value})

    appendBoard: (board)->
      ul = $(this.el).find('ul')
      boardView = new BoardView({model: board})
      ul.append(boardView.render().el)
      boardView.insertData()
