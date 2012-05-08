require ["cs!board/collection", "cs!board/model"], 
(Boards, Board)->

  describe "Boards", -> 
    
    beforeEach ->
      this.boards = new Boards({workspace_id: 1}) 

    describe "model", ->
      it "sets 'Board' as it's model", ->
        expect(this.boards.model).toEqual(Board)
   
    describe "initialize", ->
      it "sets 'the workspace_id' property on the collection instances", ->
        expect(this.boards.workspace_id).toBeDefined()

    describe "url", ->
      it "sets url by the initialization", ->
        expect(this.boards.url()).toEqual("/workspaces/1/boards") 

    
      
  
