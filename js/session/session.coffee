define [
  'backbone'
], (Backbone)->
 
  class Session extends Backbone.Model
   
     urlRoot: '/session'
