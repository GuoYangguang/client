require ["jquery", 
         "cs!board/state/collection_view",
         "cs!board/state/model",
         "cs!board/state/collection"
        ], 
($, StatesView, State, States) ->
  
  describe "StatesView", ->
    beforeEach ->
      this.data = [
        {
         "id":1,
         "name":"pending",
         "entity_id":1,
         "workspace_id":1,
         "board_id":1,
         "created_at":"2012-05-07 19:48:10",
         "updated_at":"2012-05-07 19:48:10"
        },
        {
         "id":2,
         "name":"Bdd",
         "entity_id":1,
         "workspace_id":1,
         "board_id":1,
         "created_at":"2012-05-08 19:48:10",
         "updated_at":"2012-05-08 19:48:10"
        } 
      ]
      
      models = new Array()
      for e in this.data by 1
        models.push(new State(e))
      
      this.states = new States(models, {workspaceId: 1, boardId: 1})
      this.statesView = new StatesView({collection: this.states})
      
      this.server = sinon.fakeServer.create()

    afterEach ->
      this.server.restore()

    describe "el", ->
      it "sets 'div' as root node", ->
        expect(this.statesView.tagName).toEqual "div"
   
    describe "initialize", ->
      it "binds 'add' callback to the collection", ->
        sinon.spy(StatesView.prototype, "appendState")
        
        states = new States([], {workspaceId: 1, boardId: 1})
        statesView = new StatesView({collection: states})

        states.add(
          new State(
            {
             "id":3,
             "name":"fix bugs",
             "entity_id":1,
             "workspace_id":1,
             "board_id":1,
             "created_at":"2012-05-09 19:48:10",
             "updated_at":"2012-05-09 19:48:10"
            }
          )
        )
    
        expect(StatesView.prototype.appendState.calledOnce).toBeTruthy()

        StatesView.prototype.appendState.restore()

    describe "createState", ->
      it "triggers 'success' and 'add' callbacks if gets '2**'", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards/1/states",
          [201, {"Content-Type": "application/json"}, JSON.stringify(this.data[0])]
        )
        sinon.spy(StatesView.prototype, "successCreate")
        sinon.spy(StatesView.prototype, "appendState")
        
        collection = new States([], {workspaceId: 1, boardId: 1})
        statesView = new StatesView({collection: collection})

        statesView.createState() 
        this.server.respond()
        
        expect(StatesView.prototype.successCreate.calledOnce).toBeTruthy()
        expect(StatesView.prototype.appendState.calledOnce).toBeTruthy()

        StatesView.prototype.successCreate.restore()
        StatesView.prototype.appendState.restore()

    describe "render", ->
      it "inserts a collection of states data into 'el'", ->
        this.statesView.render()
        #expect(this.stateView.el.find('span').text()).toEqual("pending")


