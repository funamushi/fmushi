class Fmushi.Views.App extends Backbone.View
  initialize: ->
    app = @

    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world

    @camera = new Fmushi.Models.Camera x: 0, y: 0, zoom: 1
    @locked = false
    
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    @listenTo @mushies, 'add', @addMushi
    @listenTo @circles, 'add', @addCircle
    
    @listenTo @camera, 'change', @onCameraChanged
    @listenTo Fmushi.Events, 'update', @collisionDetection

    loaderDefer = new $.Deferred
    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = -> loaderDefer.resolve()
    loader.load()

    $.when(
      loaderDefer.promise(),
      @circles.fetch(),
      @mushies.fetch()
    ).done _.bind(@onAssetLoaded, @)

    $(Fmushi.renderer.view).click (e) ->
      if app.hitSprite
        app.hitSprite = null
      else
        app.focusOut()

    # subviews
    @mushiesPanel = new Fmushi.Views.MushiesPanel collection: @mushies
    @mushiDialog  = new Fmushi.Views.MushiDialog
    @mushiDialog.render().$el.appendTo $('body')
    @mushiDialog.hide()

  screenCenter: ->
    new Fmushi.Vector(
      Fmushi.screenSize.w / 2, Fmushi.screenSize.h / 2
    )

  worldPosFromCamera: (camera) ->
    x = camera.get('x')
    y = camera.get('y')
    zoom = camera.get('zoom')

    center = @screenCenter()
    worldPosX = -(x * zoom - center.x)
    worldPosY = -(y * zoom - center.y)
    { x: worldPosX, y: worldPosY }

  addMushi: (mushi) ->
    view = new Fmushi.Views.MushiWalking(model: mushi)
    @views[mushi.cid] = view

  addCircle: (circle) ->
    view = new Fmushi.Views.Circle(model: circle)
    @views[circle.cid] = view

  focus: (entity) ->
    return if @focusEntity == entity

    @camera.set
      x: entity.get('x')
      y: entity.get('y')
      zoom: 2
    
    @mushiDialog.model = entity
    @mushiDialog.render().show()

    @focusEntity = entity
    @listenTo entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:in', entity

  focusOut: ->
    return unless @focusEntity

    entity = @focusEntity
    @focusEntity = null
    @camera.set zoom: 1

    @mushiDialog.hide()

    @stopListening entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:out', entity

  onCameraChanged: (camera) ->
    return if @locked

    zoom = camera.get 'zoom'
    zoomWas = camera.previous('zoom') or zoom
    
    app = @
    world = @world
    shapeWorld = @shapeWorld
    worldPos = @worldPosFromCamera(camera)

    @locked = true
    @camera.offset.x = @camera.offset.y = 0

    @tween.stop() if @tween
    @tween = new TWEEN.Tween(x: world.position.x, y: world.position.y, zoom: zoomWas)
      .to({ x: worldPos.x, y: worldPos.y, zoom: zoom }, 500)
      .easing(TWEEN.Easing.Cubic.InOut)
      .onUpdate ->
        x = @x + camera.offset.x
        y = @y + camera.offset.y
        world.position.x = x
        world.position.y = y
        world.scale.x = world.scale.y = @zoom
        shapeWorld.translation.set x, y
        shapeWorld.scale = @zoom  
      .onComplete ->
        x = worldPos.x + camera.offset.x
        y = worldPos.y + camera.offset.y
        world.position.x = x
        world.position.y = y
        world.scale.x = world.scale.y = zoom
        shapeWorld.translation.set x, y
        shapeWorld.scale = zoom
        app.locked = false
      .start()

  onFocusEntityChanged: (entity) ->
    return if @locked or @focusEntity != entity

    x = entity.get('x')
    y = entity.get('y')

    if prevX = entity.previous('x')
      @camera.offset.x += (x - prevX)
    if prevY = entity.previous('y')
      @camera.offset.y += (y - prevY)
    
    @camera.set { x: x, y: y }, {silent: true}
    worldPos = @worldPosFromCamera(@camera)
    @world.position.x = worldPos.x
    @world.position.y = worldPos.y
    @shapeWorld.translation.set worldPos.x, worldPos.y

  onAssetLoaded: (loaderArgs, circlesArgs, mushiesArgs) ->
    app = @
    @circles.each (circle) -> app.addCircle circle
    @mushies.each (mushi) -> app.addMushi mushi

    @mushiesPanel.render().$el.appendTo $('body')

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      