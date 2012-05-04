$(document).ready ->
  
  #TodoView
  class TodoView extends Backbone.View
    tagName: "li"
    
    initialize: ->
      this.model.bind("destroy", this.remove, this)
      this.model.bind("change", this.render, this)  
    events: {
               "click .check": "deleteTodo"  
               "dblclick div.todo-text": "edit"
               "keypress .todo-input": "updateTodo"
            }

    deleteTodo: ->
      this.model.destroy()
    
    edit: ->
      $(this.el).addClass("editing") 
      $(".todo-input").focus()
      
    updateTodo: (event) ->
      if (event.keyCode == 13)
        text = $(".todo-input").val()
        this.model.save(title: text)
        $(this.el).removeClass("editing")

    template: _.template($("#item-template").html())

    render: ->
      $(this.el).html(this.template(this.model.toJSON()))
      this

    remove: ->
      $(this.el).remove()
  window.TodoView = TodoView

  #AppView
  class AppView extends Backbone.View
    el: $("#todoapp")
    
    initialize: ->
      this.input = $("#new-todo")

    events: {
               "keypress #new-todo": "createTodo"
            }
    
    createTodo: (event)-> 
      text = this.input.val()
      return if (!text || event.keyCode != 13)
      Todos.create(title: text, created_at: new Date())
      this.input.val('')

    appendTodo: (todo)->
      todoView = new TodoView(model: todo)
      $("#todo-list").append(todoView.render().el)
    
    listTodos: (todos)->
       todos.each(this.appendTodo)
  window.AppView = AppView

  #Todo  
  class Todo extends Backbone.Model
    idAttribute: "_id"
    
    urlRoot: "/api/todos" 
  window.Todo = Todo

  #TodoCollection
  class TodoCollection extends Backbone.Collection
    model: Todo

    url: "/api/todos"
    
    initialize: ->
      this.bind "reset", -> 
        App.listTodos(this)
      this.bind "add", (todo) ->
        App.appendTodo(todo)

    comparator: (todo)->
      todo.get("created_at")

  window.TodoCollection = TodoCollection
  

  window.App = new AppView()
  window.Todos = new TodoCollection()
  console.log Todos
  Todos.fetch()


#def current_user
#        #return false unless session[:user_id] && session[:entity_id]
#        user = Belinkr::User::Member.new(first: 'user', last: '111', entity_id: 1)
#        user.save
#        Belinkr::User::Collection.new(entity_id: user.entity_id).add user
#        session[:user_id] = user.id
#        session[:entity_id] = user.entity_id 
#        @current_user ||= Belinkr::User::Member.new(
#           id: session[:user_id], entity_id: session[:entity_id]
#        )
#      end
