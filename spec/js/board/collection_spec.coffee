require ["libs/jquery", "libs/underscore", "libs/backbone"], ($, _, Backbone)->
  console.log $("title").text()
  console.log _
  console.log Backbone.VERSION
  describe "Boards", -> 
    it "set url", ->
      expect(true).toBeTruthy() 

#describe "Boards", -> 
#  it "set url", ->
#    expect(true).toBeTruthy()
#require ["libs/jquery", "libs/underscore", "libs/backbone"], ($, _, Backbone)->
#    console.log $("title").text()
#    console.log _
#    console.log Backbone.VERSION
