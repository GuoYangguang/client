require({
  paths: {
          cs: "libs/cs",
          order: "libs/order",
          text: "libs/text",
          jquery: "libs/jquery/jquery",
          underscore: "libs/underscore/underscore",
          backbone: "libs/backbone/backbone",
          pure: "libs/pure/pure"
  },
  priority: ["cs", "order", "text", "jquery", "underscore", "backbone", "pure"],
}, ["cs!app"]);
