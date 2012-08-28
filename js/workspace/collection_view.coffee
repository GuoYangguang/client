define [
        "jquery", 
        "underscore", 
        "backbone",
        "cs!workspace/collaborator/collection",
        "cs!workspace/collaborator/collection_view",
        "cs!workspace/board/collection", 
        "cs!workspace/board/collection_view",
        "cs!helper",
        "text!templates/workspace/workspace.html"
       ],  
($, _, Backbone, Collaborators, CollaboratorsView, Boards, BoardsView, Helper, wsHtml)->
  
  class WorkspacesView extends Backbone.View 
    
    tagName: "div"
    id: "workspace"

    initialize: ->
      this.collection.bind("reset", this.render, this)
    
    events: {
      "click#fetch-boards": "fetchBoards"
    }

    fetchWorkspaces: ->
      this.collection.fetch(
        {
         wait: true, 
         success: this.successFetch, 
         error: this.errorFetch
        }
      )

    successFetch: (collection, response)->
      $("#errors").remove()
      workspace = collection.get(1)
      collaborators = new Collaborators([], {workspaceId: workspace.id})
      colsView = new CollaboratorsView(collection: collaborators)
      colsView.fetchCols()
      $("#workspace").append(colsView.el)

    errorFetch: (collection, response)->
      helper = new Helper()
      helper.dealErrors("#workspace", response)

    render: ->
      workspace = this.collection.get(1)
      $(this.el).html(wsHtml).find("#workspace-name")
        .text(workspace.get("name"))
        .attr("data-workspace", workspace.id)
      this
 
    fetchBoards: -> 
      workspace_id = $("#workspace-name").attr("data-workspace")
      boards = new Boards([], {workspace_id: workspace_id})
      boardsView = new BoardsView({collection: boards})
      boardsView.fetchBoards()
