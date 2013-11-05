class Fmushi.Views.App extends Backbone.View
  initialize: ->
    app = @

    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world

    @camera = new Fmushi.Models.Camera
    @locked = false
    
    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = _.bind @onAssetLoaded, @, loader
    loader.load()

    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    @initMiniScreen()

    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    @listenTo @mushies, 'add', (model) ->
      view = new Fmushi.Views.MushiWalking(model: model)
      @views[model.cid] = view

    @listenTo @circles, 'add', (model) ->
      view = new Fmushi.Views.Circle(model: model)
      @views[model.cid] = view

    @listenTo @camera, 'change', @onCameraChanged
    @listenTo Fmushi.Events, 'update', @collisionDetection

  initMiniScreen: ->
    size = { x: 200, y: 200 }

    @miniScreen = miniScreen = new PIXI.DisplayObjectContainer
    miniScreen.interactive = true
    miniScreen.position.x = 800
    miniScreen.position.y = 30

    graphics = new PIXI.Graphics
    graphics.beginFill(0xFFFF00);
    graphics.lineStyle(5, 0xFF0000);
    graphics.drawRect(0, 0, size.x, size.y);
    graphics.endFill()

    graphics.hitArea = new PIXI.Rectangle(0, 0, size.x, size.y)
    graphics.interactive = true
    miniScreen.addChild graphics

    text = new PIXI.Text '地図',
      font: 'bold 16pt Arial'
      fill: 'white'
    text.anchor.x = 0.5
    text.anchor.y = 0.5
    text.position.x = size.x / 2
    text.position.y = -15
    miniScreen.addChild text

    Fmushi.stage.addChild miniScreen

    pointer = Fmushi.two.makeCircle miniScreen.position.x, miniScreen.position.y, 5
    pointer.stroke = 'orangered'
    pointer.fill = '#ff8000'
    @shapeWorld.add pointer

    app = @
    camera = @camera
    graphics.click = graphics.tap = (e) ->
      return if app.locked

      pointer.translation.set e.global

      pos = e.getLocalPosition(miniScreen)
      x = (pos.x - (size.x / 2)) * (Fmushi.screenSize.x / size.y)
      y = (pos.y - (size.y / 2)) * (Fmushi.screenSize.y / size.y)
      camera.set x: x, y: y

  onCameraChanged: (camera) ->
    zoom = camera.get 'zoom'
    zoomWas = camera.changed.zoom || zoom
    distanceX = camera.get('x') * zoom
    distanceY = camera.get('y') * zoom

    app = @
    world = @world
    shapeWorld = @shapeWorld
    destX = world.position.x - distanceX
    destY = world.position.y - distanceY

    @locked = true
    new TWEEN.Tween(x: world.position.x, y: world.position.y, zoom: zoomWas)
      .to({ x: destX, y: destY, zoom: zoom }, 500)
      .easing(TWEEN.Easing.Cubic.InOut)
      .onUpdate ->
        world.position.x = @x
        world.position.y = @y
        world.scale.x = world.scale.y = @zoom
        shapeWorld.translation.set @x, @y
        shapeWorld.scale = @zoom  
      .onComplete ->
        world.position.x = destX
        world.position.y = destY
        world.scale.x = world.scale.y = zoom
        shapeWorld.translation.set destX, destY
        shapeWorld.scale = zoom
        app.locked = false
      .start()

  onAssetLoaded: (loader) ->
    camera = @camera

    zoomInTexture  = PIXI.Texture.fromFrame('zoom_in.png')
    zoomIn  = new PIXI.Sprite(zoomInTexture)
    zoomIn.position.x = -750
    zoomIn.interactive = true
    zoomIn.click = zoomIn.tap = (e) ->
      camera.set 'zoom', (camera.get('zoom') + 0.1)
    @miniScreen.addChild zoomIn

    zoomOutTexture = PIXI.Texture.fromFrame('zoom_out.png')
    zoomOut = new PIXI.Sprite(zoomOutTexture)
    zoomOut.position.x = -700
    zoomOut.interactive = true
    zoomOut.click = zoomOut.tap = (e) ->
      camera.set 'zoom', (camera.get('zoom') - 0.1)
    @miniScreen.addChild zoomOut

    @mushies.add [{ x: 700, y: 300 }]
    @mushies.add [{ x: 850, y: 400 }]
    @mushies.add [{ x: 1000, y: 500 }]

    @circles.add [{ x: 400, y: 350, r: 300 }]

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      