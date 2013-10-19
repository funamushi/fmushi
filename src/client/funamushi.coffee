createCircle = (x, y, r) ->
  shape = new Shape()
  shape.x = x
  shape.y = y

  color = Graphics.getRGB(Math.random() * 0xffffff)
  shape.graphics
    .beginStroke('blue')
    .beginFill(color)
    .drawCircle(0, 0, r)

  filter = new BlurFilter(5, 5, 3)
  shape.filters = [filter]
  bounds = filter.getBounds()
  shape.cache -r + bounds.x, -r + bounds.y, r * 2 + bounds.width, r * 2 + bounds.height
  shape
  
init = ->
  canvas = document.getElementById('main')
  stage = new Stage(canvas)

  loader = new LoadQueue
  file = '/img/funamushi.png'
  funamushi = new Bitmap(file)

  funamushi.x = canvas.width  / 2
  funamushi.y = canvas.height / 2

  wipingShape = new Shape

  loader.loadFile {src: file, data: funamushi}
  loader.addEventListener 'fileload', (e) ->
    funamushi = e.item.data
    image  = e.result
    funamushi.x -= image.width / 2
    funamushi.y -= image.height / 2

    funamushi.regX = image.width / 2
    funamushi.regY = image.width / 2

    blurFunamushi = new Bitmap(image)
    blurFunamushi.x = funamushi.x
    blurFunamushi.y = funamushi.y
    blurFunamushi.regX = funamushi.regX
    blurFunamushi.regY = funamushi.regY
    blurFunamushi.filters = [new BlurFilter(15, 15, 2)]
    blurFunamushi.cache 0, 0, image.width, image.height

    stage.addChild blurFunamushi
    stage.addChild funamushi
    stage.update()

  stage.addEventListener 'stagemousedown', (e) ->
    point = funamushi.globalToLocal(stage.mouseX, stage.mouseY)

    wipingShape.graphics
      .beginFill(Graphics.getRGB(0xff0000, 0.5))
      .beginFill(Graphics.getRGB(255, 0, 0))
      .drawCircle(point.x, point.y, 40)

    image = funamushi.image
    
    if wipingShape.cacheCanvas?
      wipingShape.updateCache()
    else
      wipingShape.cache 0, 0, image.width, image.height

    alphaMask = new AlphaMaskFilter(wipingShape.cacheCanvas)
    funamushi.filters = [alphaMask]
    if funamushi.cacheCanvas?
      funamushi.updateCache()
    else
      funamushi.cache 0, 0, image.width, image.height

    stage.update()

  for i in [0...2]
    r = 20
    circle = createCircle(50 * (i + 1), 50, r)
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

if window.addEventListener 
  window.addEventListener 'load', init, false
else if window.attachEvent 
  window.attachEvent 'onload', init
else
  window.onload = init;
