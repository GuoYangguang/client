
require.config({
  baseUrl: "../js/", 
  paths: {
    'coffee-script': "libs/coffee-script",
    cs: "libs/cs",
    text: "libs/text",
    jquery: "libs/jquery",
    underscore: "libs/underscore",
    backbone: "libs/backbone",
    jasmine: "../spec/libs/jasmine/jasmine",
    'jasmine-html': "../spec/libs/jasmine/jasmine-html",
    spec: "../spec"
  },
  shim: {
    underscore: {exports: "_"}, 
    backbone: {deps: ["underscore", "jquery"], exports: "Backbone"},
    jasmine: {exports: "jasmine"},
    'jasmine-html': {deps: ["jasmine"], exports: "jasmine"}
  }
}); 

require(["underscore", "jquery", "jasmine-html"], function(_, $, jasmine){
  var specs = [];
  specs.push("cs!spec/test_spec");
  $(document).ready(function(){
    require(specs, function(){
      var jasmineEnv = jasmine.getEnv();
      jasmineEnv.updateInterval = 1000;

      var htmlReporter = new jasmine.HtmlReporter();

      jasmineEnv.addReporter(htmlReporter);

      jasmineEnv.specFilter = function(spec) {
        return htmlReporter.specFilter(spec);
      };

      jasmineEnv.execute();
    });
  });
});
