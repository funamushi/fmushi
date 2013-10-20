window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Events: _.extend {}, Backbone.Events
  two: (->
    canvas = document.getElementById('two-stage').children[0]
    new Two(width: 1000, height: 1000).appendTo(twoCanvas)
    )()
  stage: new PIXI.Stage 0xffffff, true
  renderer: (->
    renderer = PIXI.autoDetectRenderer(1000, 1000)
    renderer.view.style.position = "absolute"
    renderer.view.style.top = "100px"
    renderer.view.style.left = "0"

    document.body.appendChild renderer.view
    renderer
  )()

animate: ->
  requestAnimFrame animate
  Fmushi.Events.trigger 'update'
  Fmushi.renderer.render Fmushi.stage

requestAnimFrame animate
