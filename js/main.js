require({
  paths: {
          jquery: "libs/jquery/jquery",
      underscore: "libs/underscore/underscore",
        backbone: "libs/backbone/backbone",
        pure: "libs/pure/pure",
        cs: "libs/cs",
        order: "libs/order",
        text: "libs/text"
  },
  priority: ["jquery", "underscore", "backbone", "pure", "cs", "order", "text"],
}, ["cs!app"]);
