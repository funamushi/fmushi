window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events

$(->
  twoCanvas = document.getElementById('two-stage').children[0]
  Fmushi.two = new Two(width: 1000, height: 1000).appendTo(twoCanvas)

  Fmushi.stage = new PIXI.Stage 0xffffff, true

  renderer = PIXI.autoDetectRenderer(1000, 1000)
  renderer.view.style.position = "absolute"
  renderer.view.style.top = "100px"
  renderer.view.style.left = "0"
  document.body.appendChild renderer.view
  Fmushi.renderer = renderer

  animate = ->
    requestAnimFrame animate
    Fmushi.Events.trigger 'update'
    renderer.render Fmushi.stage

  requestAnimFrame animate

  window.Fmushi.Views.AppView = new Fmushi.Views.AppView
  )