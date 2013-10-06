stage = null

init = ->
  canvas = document.getElementById('main')
  stage = new createjs.Stage(canvas)

  star = new createjs.Shape
  stage.addChild star

  color = createjs.Graphics.getRGB(Math.random() * 0xFFFFFF)
  star.x = 50
  star.y = 50
  star.graphics
    .beginStroke('#0000ff')
    .beginFill(color)
    .drawPolyStar(0, 0, 40, 5, 0.6, -90)

  createjs.Ticker.setFPS(30)
  createjs.Ticker.addEventListener 'tick', ->
    rotate(star)

rotate = (shape) ->
  shape.rotation += 5
  stage.update()

if  window.addEventListener 
  window.addEventListener 'load', init, false
else if window.attachEvent 
  window.attachEvent 'onload', init
else
  window.onload = init;
