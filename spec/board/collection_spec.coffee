require ["jquery", "underscore", "backbone", "cs!board/collection"], 
($, _, Backbone, Boards)->
  describe "Boards", -> 
    it "set url", ->
      boards = new Boards()
      expect(boards.url).toEqual("/boards") 
    
