User      = require 'models/user'
Items     = require 'collections/items'

module.exports =
  events: _.extend({}, Backbone.Events)
  fps: 24
  debug: false

  start: ->
    @viewer = new User
    @items  = new Items

    @startAnimation()

    @fetch().then =>
      AppRouter = require 'routers/app'
      @router = new AppRouter
      Backbone.history.start pushState: true, root: '/'

  fetch: ->
    $.when(
      @fetchAsset ['/app.json']
      @viewer.fetchViewer()
      @items.fetch()
    )

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

    @screenSize = { w: w, h: h}
    @events.trigger 'resize', w, h

  screenCenter: ->
    { x: @screenSize.w / 2, y: @screenSize.h / 2 }

