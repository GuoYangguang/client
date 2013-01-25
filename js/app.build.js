({
  paths: {
    cs              : 'cs', //'csBuild',
    csBuild         : 'csBuild',
    CoffeeScript    : 'libs/coffeescript/CoffeeScript',
    json2           : "libs/json2/json2",
    underscore      : 'libs/underscore/underscore',
    backbone        : 'libs/backbone/backbone',
    jquery          : 'libs/jquery/jquery',
    jqueryui        : 'libs/jqueryui-1.8.14/jqueryui',
    jquery_cookie   : 'libs/jquery-cookie/jquery.cookie',
    polyfills       : 'libs/polyfills',
    fullcalendar    : 'libs/fullcalendar/fullcalendar',
    gcal            : 'libs/fullcalendar/gcal',
    strophe         : 'libs/strophe/strophe',
    timeago         : 'libs/timeago/jquery.timeago',
    chosen          : 'libs/chosen/chosen.jquery',
    click_modal     : 'libs/click-modal/jquery.click-modal',
    ajax_chosen     : 'libs/ajax-chosen/ajax-chosen.jquery',
    wysihtml5       : 'libs/wysihtml5/wysihtml5',
    paginator       : 'libs/backbone.paginator/backbone.paginator',
    scrollto       : 'libs/scrollto/jquery.scrollto'
  },
  baseUrl:          '.',
  out:              'main-built.js',
  optimize:         'uglify',
  exclude:          'CoffeeScript',
  modules:          [ {
                      name: 'main',
                      excludeShallow: [
                      ]
                    } ]
})
