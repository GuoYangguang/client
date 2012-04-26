require({
  paths: {
          jquery: "libs/jquery/jquery",
      underscore: "libs/underscore/underscore",
        backbone: "libs/backbone/backbone"
  },
  priority: ["jquery", "underscore", "backbone"],
}, ["cs!app"]);
