define [
  'backbone', 
  'text!templates/topmenu/top_menu.html'
], (Backbone, topMenuHtml)->
  
  class TopMenuView extends Backbone.View
    
    initialize: (options)->    
      @$el.html(topMenuHtml) 

    id: 'top-menu'

  
