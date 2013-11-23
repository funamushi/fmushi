class Fmushi.Views.App extends Backbone.View
  initialize: ->
    app = @

    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world

    @camera = new Fmushi.Models.Camera x: 0, y: 0, zoom: 1
    @locked = false
    
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    # @initMiniScreen()

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

    loaderDefer = new $.Deferred
    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = -> loaderDefer.resolve()
    loader.load()

    $.when(
      loaderDefer.promise(),
      @circles.fetch(reset: true),
      @mushies.fetch(reset: true)
    ).done _.bind(@onAssetLoaded, @)

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
      x = (pos.x - (size.x / 2)) * (Fmushi.screenSize.w / size.y)
      y = (pos.y - (size.y / 2)) * (Fmushi.screenSize.h / size.y)
      camera.set x: x, y: y

  screenCenter: ->
    new Fmushi.Vector(
      Fmushi.screenSize.w / 2, Fmushi.screenSize.h / 2
    )

  focus: (entity) ->
    # return if @focusEntity

    @cameraBeforeFocus = @camera.toJSON()
    @camera.set
      x: entity.get('x')
      y: entity.get('y')
      zoom: 2
    
    @focusEntity = entity
    @listenTo entity, 'change', @onFocusEntityChanged
    @trigger 'focus', entity

  onCameraChanged: (camera) ->
    center = @screenCenter()

    zoom = camera.get 'zoom'
    x = camera.get('x')
    y = camera.get('y')

    zoomWas = camera.changed.zoom || zoom
    xWas = camera.changed.x || x
    yWas = camera.changed.y || y
    
    worldPosX = -(x * zoom - center.x)
    worldPosY = -(y * zoom - center.y)

    app = @
    world = @world
    shapeWorld = @shapeWorld

    @locked = true
    new TWEEN.Tween(x: world.position.x, y: world.position.y, zoom: zoomWas)
      .to({ x: worldPosX, y: worldPosY, zoom: zoom }, 500)
      .easing(TWEEN.Easing.Cubic.InOut)
      .onUpdate ->
        world.position.x = @x
        world.position.y = @y
        world.scale.x = world.scale.y = @zoom
        shapeWorld.translation.set @x, @y
        shapeWorld.scale = @zoom  
      .onComplete ->
        world.position.x = worldPosX
        world.position.y = worldPosY
        world.scale.x = world.scale.y = zoom
        shapeWorld.translation.set worldPosX, worldPosY
        shapeWorld.scale = zoom
        app.locked = false
      .start()

  onFocusEntityChanged: (entity) ->
    # if @focusEntity == entity
    #   @camera.set x: entity.get('x'), y: entity.get('y')

  onAssetLoaded: (loaderArgs, circlesArgs, mushiesArgs) ->
    camera = @camera

    zoomInTexture  = PIXI.Texture.fromFrame('zoom_in.png')
    zoomIn  = new PIXI.Sprite(zoomInTexture)
    zoomIn.position.x = -750
    zoomIn.interactive = true
    zoomIn.click = zoomIn.tap = (e) ->
      camera.set 'zoom', (camera.get('zoom') + 0.1)

    zoomOutTexture = PIXI.Texture.fromFrame('zoom_out.png')
    zoomOut = new PIXI.Sprite(zoomOutTexture)
    zoomOut.position.x = -700
    zoomOut.interactive = true
    zoomOut.click = zoomOut.tap = (e) ->
      camera.set 'zoom', (camera.get('zoom') - 0.1)

    if @miniScreen
      @miniScreen.addChild zoomIn
      @miniScreen.addChild zoomOut

    @circles.add circlesArgs[0]
    @mushies.add mushiesArgs[0]

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      