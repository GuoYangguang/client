define [
        "jquery", 
        "underscore", 
        "backbone", 
        "cs!workspace/collaborator/model_view",
        "cs!helper"
       ],
($, _, Backbone, CollaboratorView, Helper)->
  
  class CollaboratorsView extends Backbone.View
    
    tagName: "ul"

    initialize: ->
      this.collection.bind("reset", this.render, this)
    
    fetchCols: ->
      this.collection.fetch(
        {
         wait: true, 
         success: this.successFetch, 
         error: this.errorFetch
        }
      )
        
    successFetch: (collection, response)->
      $("#errors").remove()

    errorFetch: (collection, response)->
      helper = new Helper()
      helper.dealErrors("#fetch-boards", response)

    render: ->
      ulNode = this.$el
      this.collection.each (collaborator)->
        colView = new CollaboratorView(model: collaborator) 
        ulNode.append(colView.render().$("li"))
      $("#workspace-name").after(this.el)
      this
    
