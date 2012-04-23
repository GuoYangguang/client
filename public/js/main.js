(function() {

  require({
    baseUrl: "public/js",
    paths: {
      "jquery": "lib/jquery/jquery",
      "underscore": "lib/underscore/underscore",
      "backbone": "lib/backbone/backbone"
    },
    priority: ["jquery", "underscore", "backbone"]
  }, ["cs!app"]);

}).call(this);
