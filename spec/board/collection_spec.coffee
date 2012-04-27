require ["cs!board/collection", "cs!board/model"], 
(Boards, Board)->
  describe "Boards", -> 
    it "sets url, model", ->
      boards = new Boards()
      expect(boards.url).toEqual("/boards") 
      expect(boards.model).toEqual(Board)
    
