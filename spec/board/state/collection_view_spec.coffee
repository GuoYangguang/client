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
       
      this.models = new Array()
      for e in this.data by 1
        this.models.push(new State(e))

      this.states = new States([], {workspaceId: 1, boardId: 1})

      this.server = sinon.fakeServer.create()

    afterEach ->
      this.server.restore()

    describe "el", ->
      it "sets 'div' as root node", ->
        statesView = new StatesView({collection: this.states})
        
        expect(statesView.tagName).toEqual "div"
   
    describe "initialize", ->
      it "binds 'add' callback to the collection", ->
        sinon.spy(StatesView.prototype, "appendState")
        
        statesView = new StatesView({collection: this.states})

        this.states.add(
          new State(this.data[0])
        )
    
        expect(StatesView.prototype.appendState.calledOnce).toBeTruthy()

        StatesView.prototype.appendState.restore()

      it "binds 'reset' callback to the collection", ->
        sinon.spy(StatesView.prototype, "render")
         
        statesView = new StatesView({collection: this.states})
        this.states.reset(this.models)

        expect(StatesView.prototype.render.calledOnce).toBeTruthy()

        StatesView.prototype.render.restore()

    describe "createState", ->
      it "triggers 'success' and 'add' callbacks if gets '2**'", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards/1/states",
          [201, {"Content-Type": "application/json"}, JSON.stringify(this.data[0])]
        )
        sinon.spy(StatesView.prototype, "successCreate")
        sinon.spy(StatesView.prototype, "appendState")
        
        statesView = new StatesView({collection: this.states})

        statesView.createState() 
        this.server.respond()
        
        expect(StatesView.prototype.successCreate.calledOnce).toBeTruthy()
        expect(StatesView.prototype.appendState.calledOnce).toBeTruthy()

        StatesView.prototype.successCreate.restore()
        StatesView.prototype.appendState.restore()

      it "triggers 'error' but not 'add' callbacks if gets 'non 2**'", ->
        this.server.respondWith(
          "POST",
          "/workspaces/1/boards/1/states",
          [404, {}, ""]
        )
        
        sinon.spy(StatesView.prototype, "errorCreate")
        sinon.spy(StatesView.prototype, "appendState")

        statesView = new StatesView({collection: this.states})

        statesView.createState()
        this.server.respond()
        
        expect(StatesView.prototype.errorCreate.calledOnce).toBeTruthy()
        expect(StatesView.prototype.appendState.calledOnce).not.toBeTruthy()

        StatesView.prototype.errorCreate.restore()
        StatesView.prototype.appendState.restore()
    
    describe "fetchStates", ->
      it "triggers 'success' and 'reset' callbacks if gets '2**'", ->
        this.server.respondWith(
          "GET",
          "/workspaces/1/boards/1/states",
          [200, {"Content-Type": "application/json"}, JSON.stringify(this.data)]
        )   

        sinon.spy(StatesView.prototype, "successFetch")
        sinon.spy(StatesView.prototype, "render")
        
        statesView = new StatesView({collection: this.states})
        statesView.fetchStates()
        this.server.respond()
        
        expect(StatesView.prototype.successFetch.calledOnce).toBeTruthy()
        expect(StatesView.prototype.render.calledOnce).toBeTruthy()

        StatesView.prototype.successFetch.restore()
        StatesView.prototype.render.restore()

    describe "render", ->
      it "inserts a collection of states data into 'el'", ->
        #this.statesView.render()
        #expect(this.stateView.el.find('span').text()).toEqual("pending")


