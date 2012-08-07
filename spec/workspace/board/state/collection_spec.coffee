require ["underscore", 
         "backbone", 
         "cs!workspace/board/state/collection", 
         "cs!workspace/board/state/model"
        ],
(_, Backbone, States, State) ->
   
  describe "States", ->
     
    beforeEach ->
      this.states = new States([], {workspaceId: 1, boardId: 1})
    
    describe "initialize", ->
      it "sets the 'workspaceId' and 'boardId' properties", ->
        expect(this.states.workspaceId).toEqual 1

    describe "model", ->
      it "defines 'State' as model the collection serves", ->
        expect(this.states.model).toEqual State

    describe "url", ->
      it "returns the base url by 'workspaceId' and 'boardId' properties", ->
        expect(this.states.url()).toEqual( 
          "/workspaces/#{this.states.workspaceId}/boards/#{this.states.boardId}/states")

         
