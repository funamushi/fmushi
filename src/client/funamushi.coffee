createCircle = (x, y, r) ->
  shape = new Shape()
  shape.x = x
  shape.y = y

  color = Graphics.getRGB(Math.random() * 0xffffff)
  shape.graphics
    .beginStroke('blue')
    .beginFill(color)
    .drawCircle(0, 0, r)

  shape
  
init = ->
  canvas = document.getElementById('main')
  stage = new Stage(canvas)

  loader = new LoadQueue

  file = '/img/funamushi.png'
  bitmap = new Bitmap(file)

  bitmap.addEventListener 'click', (e) ->
    console.log 'rotate'
  bitmap.x = canvas.width  / 2
  bitmap.y = canvas.height / 2

  loader.loadFile {src: file, data: bitmap}
  loader.addEventListener 'fileload', (e) ->
    bitmap = e.item.data
    image  = e.result
    bitmap.x -= image.width / 2
    bitmap.y -= image.height / 2
    stage.addChild bitmap
    stage.update()

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

  # Ticker.setFPS(30)
  # Ticker.addEventListener 'tick', ->
  #   stage.update()
  stage.update()

if  window.addEventListener 
  window.addEventListener 'load', init, false
else if window.attachEvent 
  window.attachEvent 'onload', init
else
  window.onload = init;
