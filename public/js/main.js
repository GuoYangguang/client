//When using require() in the top-level HTML page (or top-level script file that does
//not define a module), a configuration object can be passed as the first option
//require.config({
//
//the root path to use for all module lookups, this is most important
//require is actuallly a script tag,and public path is configured on server
//  baseUrl: "public/js",
//
//the mappings for module names not found directly under baseUrl.
//The path settings are assumed to be relative to baseUrl
//  paths: {
//  },
//
//An array of module/file names to load immediately, before tracing down 
//any other dependencies 
//order! load itself using base path
//order! load libs in order 
//  priority: ["lib/jquery/jquery", "lib/underscore/underscore", "lib/backbone/backbone"]
//});
//
//cs! load itself and coffeescript using base path
//cs! is a resource loading plugin
require(["libs/jquery", "libs/underscore", "libs/backbone", "cs!router"], 
  function($, _, Backbone, AppRouter) {
  $(document).ready(function() {
    var app;
    app = new AppRouter();
    Backbone.history.start();
  });
});

