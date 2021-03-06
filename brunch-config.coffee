exports.config =
  paths:
    public: 'public'
    watched: ['src/client', 'src/css', 'assets']

  modules:
    wrapper: 'commonjs',
    nameCleaner: (path) ->
      path.replace(/^src\/client\//, '')

  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'js/vendor.js': /^bower_components/
        'js/app.js': /^src\/client/
      order:
        before: [
          "bower_components/zeptojs/src/zepto.js"
          "bower_components/zeptojs/src/event.js"
          "bower_components/zeptojs/src/ajax.js"
          "bower_components/zeptojs/src/callbacks.js"
          "bower_components/zeptojs/src/deferred.js"
          "bower_components/zeptojs/src/selector.js"
          "bower_components/zeptojs/src/detect.js"
          'bower_components/lodash/dist/lodash.js'
          'bower_components/backbone/backbone.js'
          'bower_components/backbone.localstorage/backbone.localStorage.js'
        ]
    templates:
      defaultExtension: 'hbs'
      joinTo: 'js/app.js'
    stylesheets:
      defaultExtension: 'scss'
      joinTo:
        'css/app.css': /^(bower_components|src\/css)/
      order:
        before: [
          "bower_components/bootstrap/dist/css/bootstrap.css"
        ]

  plugins:
    autoReload:
      enabled:
        css: on
        js: on
        assets: on
      port: [1234, 2345, 3456]
