window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events
  screenSize:
    w: 1000
    h: 1000
  debug: false
  fps: 30
  initialize: ->
    $window = $(window)
    w = $window.width()
    h = $window.height()

    Two.Resolution = 12;

    Fmushi.two = new Two(fullscreen: true).appendTo(document.body)
    Fmushi.stage = new PIXI.Stage 0x000000, true
    Fmushi.stage.interactive = true
    Fmushi.stage.interactionManager.preventDefault = false

    renderer = PIXI.autoDetectRenderer w, h, null, true
    renderer.view.id = 'stage'
    renderer.view.style.position = "absolute"
    renderer.view.style.top  = "0"
    renderer.view.style.left = "0"
    document.body.appendChild renderer.view
    Fmushi.renderer = renderer

    @onResize()
    $(window).resize _.bind(@onResize, @)

    window.Fmushi.app = new Fmushi.Views.App

    @start()

  start: ->
    interval = 1 / @fps

    getTime = @getTime
    @startTime = lastTime = getTime()
    @frames = 0

    two = @two
    stage = @stage
    renderer = @renderer
    Events = Fmushi.Events
    elapsed = 0
    mainLoop = => 
      currentTime = getTime()
      delta = currentTime - lastTime
      elapsed += delta

      requestAnimFrame mainLoop
      renderer.render stage
      if elapsed >= interval
        TWEEN.update()
        two.update()
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

    @renderer.resize(w, h)

    @screenSize.w = w
    @screenSize.h = h
    Fmushi.Events.trigger 'resize', @screenSize

class Fmushi.Vector extends Two.Vector
  toJSON: ->
    { x: @x, y: @y }

Fmushi.vec2 = (x, y) ->
   new Fmushi.Vector(x, y)

$ ->
  Fmushi.initialize()
 