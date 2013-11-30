exports.config =
  paths:
    public: 'public'
    watched: ['src/client', 'src/css']

  modules:
    wrapper: false,
    nameCleaner: (path) ->
      path.replace(/^src\/client\//, '')

  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'js/vendor.js': /^bower_components/
        'js/app.js': /^src\/client/
    templates:
      defaultExtension: 'hbs'
      joinTo: 'js/app.js'
      order:
        before: [
          'src/client/fmushi.coffee'
          'src/client/views/base.coffee'
        ]
    stylesheets:
      defaultExtension: 'scss'
      joinTo:
        'css/app.css': /^(bower_components|src\/scss)/

  server:
    path: 'brunch_server'
    port: 3000
    base: '/'
    app: 'src/server/app'
    persistent: true
    interval: 100
    watched: ['src/server']
    ignore: /(^[.#]|(?:~)$)/
    source: /\.coffee$/
    module: 'watch'
    tester:
      enabled: false

  plugins:
    autoReload:
      enabled:
        css: on
        js: on
        assets: on
      port: [1234, 2345, 3456]
    handlebars:
      namespace: 'JST'
