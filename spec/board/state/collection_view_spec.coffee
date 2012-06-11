require ["jquery", "cs!board/state/collection_view"], ($, StatesView) ->
  
  beforeEach ->
    this.statesView = new StatesView()

  describe "el", ->
    it "sets 'div' as root node", ->
      expect(this.statesView.tagName).toEqual "div"
