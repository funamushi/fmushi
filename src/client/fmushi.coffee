window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events
  screenSize:
    x: 1000
    y: 1000
  debug: false
  initialize: ->
    Two.Resolution = 12;

    Fmushi.two = new Two(
      width:  Fmushi.screenSize.x
      height: Fmushi.screenSize.y
      fullscreen: true
      ).appendTo(document.body)

    Fmushi.stage = new PIXI.Stage 0x000000, true

    renderer = PIXI.autoDetectRenderer Fmushi.screenSize.x, Fmushi.screenSize.y, null, true
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

class Fmushi.Vector extends Two.Vector
  toJSON: ->
    { x: @x, y: @y }

Fmushi.vec2 = (x, y) ->
   new Fmushi.Vector(x, y)

$ ->
  Fmushi.initialize()
 