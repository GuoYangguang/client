require ["cs!board/model"], (Board) ->
  describe "Board", ->
    it "sets url", ->
      board = new Board()
      expect(board.urlRoot).toEqual("/boards")
