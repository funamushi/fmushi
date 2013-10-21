window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events

$(->
  Two.Resolution = 12;

  Fmushi.two = new Two(
    width: 1000
    height: 1000
    fullscreen: true
    ).appendTo(document.body)

  Fmushi.stage = new PIXI.Stage 0x000000, true
  Fmushi.stage.worldAlpha = 0
  Fmushi.stage.alpha = 0

  renderer = PIXI.autoDetectRenderer(1000, 1000, null, true)
  renderer.view.style.position = "absolute"
  renderer.view.style.top  = "0"
  renderer.view.style.left = "0"
  document.body.appendChild renderer.view
  Fmushi.renderer = renderer

  animate = ->
    requestAnimFrame animate
    Fmushi.Events.trigger 'update'
    Fmushi.two.update()
    renderer.render Fmushi.stage

  requestAnimFrame animate

  window.Fmushi.Views.World = new Fmushi.Views.World
  )