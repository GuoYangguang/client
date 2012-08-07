require ["cs!board/collection", "cs!board/model"], 
(Boards, Board)->

  describe "Boards", -> 
    
    beforeEach ->
      this.boards = new Boards([], {workspace_id: 1}) 

      this.data = [
        {"id":1,"name":"board1","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-07 19:48:10","updated_at":"2012-05-07 19:48:10"},
        {"id":2,"name":"board2","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-06 19:48:10","updated_at":"2012-05-07 19:48:10"},
        {"id":3,"name":"board3","entity_id":1,"workspace_id":1,"user_id":1,
        "created_at":"2012-05-08 19:48:10","updated_at":"2012-05-07 19:48:10"}
      ]
    
    describe "model", ->
      it "sets 'Board' as it's model", ->
        expect(this.boards.model).toEqual(Board)

    describe "url", ->
      it "sets url by the 'workspace_id' property", ->
        expect(this.boards.workspace_id).toEqual 1
        expect(this.boards.url()).toEqual("/workspaces/1/boards") 
 
    describe "comparator", ->
      it "sorts the collection by the model's 'created_at' attribute", ->
        models = new Array()
        for e in this.data by 1
          models.push new Board(e)
        boards = new Boards(models, {workspace_id: 1})        
           
        expect(boards.pluck("name")).toEqual ["board2", "board1", "board3"]
    
      
  
