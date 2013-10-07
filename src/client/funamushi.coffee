stage = null

init = ->
  canvas = document.getElementById('main')
  stage = new createjs.Stage(canvas)

  star = new createjs.Shape
  stage.addChild star

  color = createjs.Graphics.getRGB(Math.random() * 0xFFFFFF)
  radius = 40
  star.x = 50
  star.y = 50
  star.graphics
    .beginStroke('#0000ff')
    .beginFill(color)
    .drawPolyStar(0, 0, radius, 5, 0.6, -90)

  createjs.Tween.get(star, loop: true)
    .to({rotation: 360, y: canvas.height - radius}, 5000, createjs.Ease.bounceOut)
    .wait(1000)
    .to({alpha: 0}, 2500, createjs.Ease.circIn)

  createjs.Ticker.setFPS(30)
  createjs.Ticker.addEventListener 'tick', ->
    stage.update()

if  window.addEventListener 
  window.addEventListener 'load', init, false
else if window.attachEvent 
  window.attachEvent 'onload', init
else
  window.onload = init;
