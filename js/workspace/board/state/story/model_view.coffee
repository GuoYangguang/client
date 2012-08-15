define [
        "jquery",
        "underscore",
        "backbone",
        "text!templates/workspace/board/state/story/story.html",
        "cs!helper"
       ],
($, _, Backbone, storyHtml, Helper)->
  
  class StoryView extends Backbone.View
    tagName: "li"


