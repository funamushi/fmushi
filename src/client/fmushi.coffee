module.exports =
  events: _.extend({}, Backbone.Events)
  fps: 24
  debug: false

  start: ->
    $ ->
      FastClick.attach document.body

    vex.defaultOptions.className = 'vex-theme-fmushi-wireframe'

    @startAnimation()
    @startClock()

    Viewer = require 'models/viewer'

    @viewer = new Viewer
    @fetch().then =>
      AppRouter = require 'routers/app'
      @router = new AppRouter
      Backbone.history.start pushState: true, root: '/'

  scene: (name, options={}) ->
    if name isnt @currentSceneName
      prev = @currentScene
      if prev?
        prev.transitionOut().done ->
          prev.dispose()

      Scene = require("scenes/#{name}")
      @currentScene = nextScene = new Scene(options)
      nextScene.once 'ready', ->
        nextScene.transitionIn()

      @currentSceneName = name

  fetch: ->
    elements = require 'elements'

    $.when(
      elements.fetch()
      @fetchAsset(['/app.json'])
    ).then =>
      @viewer.fetch()

  fetchAsset: (args) ->
    defer = $.Deferred()
    loader = new PIXI.AssetLoader args
    loader.onComplete = ->
      defer.resolve()
    loader.load()

    defer.promise()

  startAnimation: ->
    $(document)
    .on('touchmove', (e) ->
      e.preventDefault())

    $window = $(window)
    w = $window.width()
    h = $window.height()

    Two.Resolution = 16

    @two = two = new Two(fullscreen: true).appendTo(document.body)
    @stage = stage = new PIXI.Stage 0x000000, true
    @interactive = true

    @renderer = renderer = PIXI.autoDetectRenderer w, h, null, true
    renderer.view.id = 'stage'
    renderer.view.style.position = "absolute"
    renderer.view.style.top  = "0"
    renderer.view.style.left = "0"
    document.body.appendChild renderer.view

    @onResize()
    $(window).resize _.debounce(_.bind(@onResize, @), 260)

    interval = 1 / @fps

    getTime = @getTime
    @startTime = lastTime = getTime()
    @frames = 0

    elapsed = 0
    mainLoop = =>
      currentTime = getTime()
      delta = currentTime - lastTime
      elapsed += delta

      requestAnimFrame mainLoop
      if elapsed >= interval
        TWEEN.update()
        two.update()
        renderer.render stage
        @events.trigger 'update', elapsed
        elapsed = 0

      lastTime = getTime()
    requestAnimFrame mainLoop

  startClock: ->
    setInterval =>
      @events.trigger 'countdown', (new Date)
    , 1000

  getTime: ->
    now = window.performance && (
      performance.now ||
      performance.mozNow ||
      performance.msNow ||
      performance.oNow ||
      performance.webkitNow)

    msec = (now && now.call(performance)) || (new Date().getTime())
    msec * 0.001

  onResize: ->
    $window = $(window)
    w = $window.width()
    h = $window.height()

    @renderer.resize(w, h)

    @screenSize   = { w: w, h: h}
    @screenCenter = { x: w * 0.5, y: h * 0.5}
    @events.trigger 'resize', w, h

