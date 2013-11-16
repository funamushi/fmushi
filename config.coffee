exports.config =
  paths:
    public: 'public'
    watched: ['src']

  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'js/app.js': /^src\/client/
        'js/vendor.js': /^bower_components/
      order:
        before: ['src/client/fmushi.coffee']
    templates:
      defaultExtension: 'hbs'
      joinTo: 'js/app.js'

  server:
    path: 'brunch_server'
    port: 3000
    base: '/'
    app: 'src/server/app'
    persistent: true
    interval: 100
    watched: ['src/server']
    ignore: /(^[.#]|(?:~)$)/
    source: /.*\.coffee$/
    tester:
      enabled: false
    

