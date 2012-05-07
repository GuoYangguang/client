require ["cs!board/collection", "cs!board/model"], 
(Boards, Board)->
  describe "Boards", -> 
    it "sets url, model", ->
      boards = new Boards({workspace_id: 1})
      url = boards.url()
      expect(url).toEqual("/workspaces/1/boards") 
      expect(boards.model).toEqual(Board)
    
