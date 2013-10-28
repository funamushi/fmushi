window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events
  debug: false

class Fmushi.Vector extends Two.Vector
  toJSON: ->
    { x: @x, y: @y }

Fmushi.vec2 = (x, y) -> new Fmushi.Vector(x, y)

$(->
  Two.Resolution = 12;

  Fmushi.two = new Two(
    width: 1000
    height: 1000
    fullscreen: true
    ).appendTo(document.body)

  Fmushi.stage = new PIXI.Stage 0x000000, true

  renderer = PIXI.autoDetectRenderer(1000, 1000, null, true)
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
  )