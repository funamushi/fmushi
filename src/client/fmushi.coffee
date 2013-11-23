window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events
  screenSize:
    w: 1000
    h: 1000
  debug: false
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
    renderer.view.style.position = "absolute"
    renderer.view.style.top  = "0"
    renderer.view.style.left = "0"
    document.body.appendChild renderer.view
    Fmushi.renderer = renderer

    animate = ->
      requestAnimFrame animate
      Fmushi.Events.trigger 'update'
      TWEEN.update()
      Fmushi.two.update()
      renderer.render Fmushi.stage

    requestAnimFrame animate

    window.Fmushi.app = new Fmushi.Views.App

    @onResize()
    $(window).resize _.bind(@onResize, @)

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
 