createCircle = (x, y, r) ->
  shape = new createjs.Shape()
  shape.x = x
  shape.y = y

  color = createjs.Graphics.getRGB(Math.random() * 0xffffff)
  shape.graphics
    .beginStroke('blue')
    .beginFill(color)
    .drawCircle(0, 0, r)

  shape
  

init = ->
  canvas = document.getElementById('main')
  stage = new createjs.Stage(canvas)

  for i in [0...2]
    circle = createCircle(50 * (i + 1), 50, 20)
    circle.addEventListener 'mousedown', (e) ->
      shape = e.target
      shape.dragging = true

    circle.addEventListener 'pressmove', (e) ->
      shape = e.target
      shape.x = e.stageX + shape.regX
      shape.y = e.stageY + shape.regY
      stage.update()

    circle.addEventListener 'pressup', (e) ->
      e.target.dragging = false

    stage.addChild(circle)

  # createjs.Ticker.setFPS(30)
  # createjs.Ticker.addEventListener 'tick', ->
  #   stage.update()
  stage.update()

if  window.addEventListener 
  window.addEventListener 'load', init, false
else if window.attachEvent 
  window.attachEvent 'onload', init
else
  window.onload = init;
