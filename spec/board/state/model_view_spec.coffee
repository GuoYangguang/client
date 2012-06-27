require ["jquery",
         "cs!board/state/model", 
         "cs!board/state/model_view"
        ], 
($, State, StateView) ->

  describe "StateView", ->
    beforeEach ->
      this.data = {
        "id":1,
        "name":"pending",
        "entity_id":1,
        "workspace_id":1,
        "board_id":1,
        "created_at":"2012-05-07 19:48:10",
        "updated_at":"2012-05-07 19:48:10"
      }
      this.state = new State(this.data)
      this.stateView = new StateView(model: this.state)

    describe "el", ->
      it "sets 'div' as root node", ->
        expect(this.stateView.tagName).toEqual "div"
   
    describe "render", ->
      it "inserts 'state' data into 'el'", ->
        this.stateView.render()
        expect($(this.stateView.el).find('span').first().text()).toEqual("pending")


