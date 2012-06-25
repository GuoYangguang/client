require({
  basePath: "spec",
  paths: {
          jquery: "libs/jquery/jquery",
      underscore: "libs/underscore/underscore",
        backbone: "libs/backbone/backbone",
        pure: "libs/pure/pure"
  },
  priority: ["jquery", "underscore", "backbone", "pure"],
}, ["cs!app"]);
