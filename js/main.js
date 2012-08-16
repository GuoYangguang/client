require(
  {
   paths: {
            cs: "libs/cs",
            order: "libs/order",
            text: "libs/text",
            jquery: "libs/jquery/jquery",
            underscore: "libs/underscore/underscore",
            backbone: "libs/backbone/backbone",
            pure: "libs/pure/pure",
            jqueryUI: "libs/jquery-ui-1.8.22.custom/js/jquery-ui-1.8.22.custom.min"
          },
   priority: ["cs", "order", "text", "jquery", "underscore", "backbone", 
     "pure", "jqueryUI"]
 }, 
 ["cs!app"]
);
