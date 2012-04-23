(function() {

  require({
    baseUrl: "public/js",
    paths: {
      "jquery": "lib/jquery/jquery",
      "underscore": "lib/underscore/underscore",
      "backbone": "lib/backbone/backbone"
    },
    priority: ["jquery", "underscore", "backbone"]
  }, ["cs!router"], function(AppRouter) {
    return $(document).ready(function() {
      var app;
      app = new AppRouter();
      return Backbone.history.start();
    });
  });

}).call(this);
