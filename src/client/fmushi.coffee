window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Scenes: {}
  Routers: {}
  Events: _.extend {}, Backbone.Events
  fps: 24
  debug: false
  initialize: ->
    Fmushi.viewer = viewer = new Fmushi.Models.Viewer
    Fmushi.items  = items  = new Fmushi.Collections.Items
    Fmushi.ranks  = ranks  = new Fmushi.Collections.Ranks

    if _.contains $('title').text(), 'F虫'
      @startAnimation()
      @fetch()

  fetch: ->
    $.when(
      @fetchAsset ['/app.json']
      viewer.fetch()
      items.fetch()
      ranks.fetch()
    ).done =>
      Fmushi.header = header = new Fmushi.Views.Header
      header.render()
      @router = new Fmushi.Routers.App
      Backbone.history.start pushState: true, root: '/'

  fetchAsset: (args) ->
    defer = $.Deferred()
    loader = new PIXI.AssetLoader args
    loader.onComplete = ->
      defer.resolve()
    loader.load()

    defer.promise()

  startAnimation: -> 
    $window = $(window)
    w = $window.width()
    h = $window.height()

    Two.Resolution = 16;

    Fmushi.two = two = new Two(fullscreen: true).appendTo(document.body)
    Fmushi.stage = stage = new PIXI.Stage 0x000000, true
    stage.interactive = true

    Fmushi.renderer = renderer = PIXI.autoDetectRenderer w, h, null, true
    renderer.view.id = 'stage'
    renderer.view.style.position = "absolute"
    renderer.view.style.top  = "0"
    renderer.view.style.left = "0"
    document.body.appendChild renderer.view

    @onResize()
    $(window).resize _.bind(@onResize, @)

    interval = 1 / @fps

    getTime = @getTime
    @startTime = lastTime = getTime()
    @frames = 0

    Events = Fmushi.Events
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
        Events.trigger 'update', elapsed
        elapsed = 0

      lastTime = getTime()
    requestAnimFrame mainLoop

  getTime: -> 
    now = window.performance && (
      performance.now || 
      performance.mozNow || 
      performance.msNow || 
      performance.oNow || 
      performance.webkitNow );

    msec = (now && now.call(performance)) || (new Date().getTime())
    msec * 0.001

  onResize: ->
    $window = $(window)
    w = $window.width()
    h = $window.height()

    Fmushi.renderer.resize(w, h)

    @screenSize = { w: w, h: h}
    Fmushi.Events.trigger 'resize', @screenSize

  screenCenter: ->
    { x: @screenSize.w / 2, y: @screenSize.h / 2 }

class Fmushi.Vector extends Two.Vector
  toJSON: ->
    { x: @x, y: @y }

Fmushi.vec2 = (x, y) ->
   new Fmushi.Vector(x, y)

$ ->
  Fmushi.initialize()
 