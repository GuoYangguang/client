describe 'Test', -> 

  beforeEach ->
    flag = false
    that = this
    require ['cs!test'], (Test)->
      that.test = new Test()
      flag = true
    waitsFor(-> flag)

  describe 'test', -> 
    it 'return a str', -> 
      expect(this.test.test).toEqual('i am test')

