exports.config =
  paths:
    public: 'public'
    watched: ['src/client', 'src/css']

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
          'bower_components/jquery/jquery.js'
          'bower_components/lodash/dist/lodash.js'
          'bower_components/backbone/backbone.js'
        ]
    templates:
      defaultExtension: 'hbs'
      joinTo: 'js/app.js'
    stylesheets:
      defaultExtension: 'scss'
      joinTo:
        'css/app.css': /^(bower_components|src\/css)/

  plugins:
    autoReload:
      enabled:
        css: on
        js: on
        assets: on
      port: [1234, 2345, 3456]
    sass:
      outputStyle: 'compressed'
