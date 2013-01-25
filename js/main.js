
require.config({
  baseUrl: "../js/", 
  paths: {
    'coffee-script': "libs/coffee-script",
    cs: "libs/cs",
    text: "libs/text",
    jquery: "libs/jquery",
    underscore: "libs/underscore",
    backbone: "libs/backbone",
    pure: "libs/pure/pure",
    jqueryUI: "libs/jquery-ui-1.8.22.custom/js/jquery-ui-1.8.22.custom.min"
  },
  shim: {
    underscore: {exports: "_"}, 
    backbone: {deps: ["underscore", "jquery"], exports: "Backbone"}  
  }
}); 

require(["cs!app"]);
  


