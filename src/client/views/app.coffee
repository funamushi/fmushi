class Fmushi.Views.App extends Fmushi.Views.Base
  initialize: ->
    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world

    @camera = new Fmushi.Models.Camera x: 0, y: 0, zoom: 1
    @locked = false
    
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    @listenTo @mushies, 'add', @addMushi
    @listenTo @circles, 'add', @addCircle
    
    @listenTo @camera, 'change', @onCameraChanged
    @listenTo Fmushi.Events, 'update', @collisionDetection

    @initDrag()

    # subviews
    panelView = new Fmushi.Views.MushiesPanel collection: @mushies
    @subview 'panel', panelView

    dialogView = new Fmushi.Views.MushiDialog
    dialogView.hide()
    @subview 'dialog', dialogView

    # @listenTo Fmushi.Events, 'update', (delta) ->
    #   Fmushi.renderer.view.style.cursor = ''
    @fetch()

  fetch: -> 
    loaderDefer = new $.Deferred
    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = -> loaderDefer.resolve()
    loader.load()

    $.when(
      loaderDefer.promise(),
      @circles.fetch(add: true),
      @mushies.fetch(add: true, update: true)
    ).done _.bind(@onAssetLoaded, @)

  initDrag: ->
    $canvas = $(Fmushi.renderer.view)
    $canvas.on 'mousedown touchstart', (e) => 
      if !@hitSprite and !@focusEntity
        @lastDragPoint = { x: e.pageX, y: e.pageY }

    $canvas.on 'mousemove touchmove', (e) =>
      if @lastDragPoint and !@focusEntity
        x = e.pageX
        y = e.pageY
        diffX = @lastDragPoint.x - x
        diffY = @lastDragPoint.y - y
        @camera.set { x: @camera.get('x') + diffX, y: @camera.get('y') + diffY}, {tween: false }
        @lastDragPoint = { x: x, y: y }
      
    $canvas.on 'mouseout mouseleave touchcancel', (e) =>
      @lastDragPoint = null

    $canvas.on 'mouseup touchend', (e) =>
      # pixi.jsスプライトのクリックイベントが先に発生してたら、今回は無視
      if @hitSprite
        @hitSprite = null
      else
        if @focusEntity
          @focusOut()
        @lastDragPoint = null

    $canvas.on 'mousewheel', (e) =>
      x = @camera.get('x')
      y = @camera.get('y')
      @camera.set { x: x + e.deltaX, y: y - e.deltaY }, { tween: false }
    

  screenCenter: ->
    new Fmushi.Vector(
      Fmushi.screenSize.w / 2, Fmushi.screenSize.h / 2
    )

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi

  worldPosFromCameraPos: (x, y, zoom) ->
    camera = @camera
    x ?= camera.get('x')
    y ?= camera.get('y')
    zoom ?= camera.get('zoom')

    center = @screenCenter()
    worldPosX = -(x * zoom - center.x)
    worldPosY = -(y * zoom - center.y)
    { x: worldPosX, y: worldPosY }

  addMushi: (mushi) ->
    view = new Fmushi.Views.Mushi(model: mushi)
    @subview mushi.cid, view

  addCircle: (circle) ->
    view = new Fmushi.Views.Circle(model: circle)
    @subview circle.cid, view

  focus: (entity) ->
    return if @focusEntity == entity

    @camera.set
      x: entity.get('x')
      y: entity.get('y')
      zoom: 2
    
    dialog = @subview('dialog')
    dialog.model = entity
    dialog.render().$el.appendTo($('body'))
    dialog.show()

    @focusEntity = entity
    @listenTo entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:in', entity

  focusOut: ->
    return unless @focusEntity

    entity = @focusEntity
    @focusEntity = null
    @camera.set zoom: 1

    @subview('dialog').hide()

    @stopListening entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:out', entity

  cameraFixed: (x, y, zoom) ->
    camera     = @camera
    world      = @world
    shapeWorld = @shapeWorld

    x ?= camera.get('x')
    y ?= camera.get('y')
    zoom ?= camera.get('zoom')
    worldPos = @worldPosFromCameraPos x, y, zoom

    x = worldPos.x
    y = worldPos.y
    world.position.x = x
    world.position.y = y
    world.scale.x = world.scale.y = zoom
    shapeWorld.translation.set x, y
    shapeWorld.scale = zoom

  onCameraChanged: (camera, options) ->
    return if @locked

    x    = camera.get 'x'
    y    = camera.get 'y'
    zoom = camera.get 'zoom'
    xWas    = camera.previous('x') or x
    yWas    = camera.previous('y') or y
    zoomWas = camera.previous('zoom') or zoom
    
    app = @
    worldPosFrom = @worldPosFromCameraPos xWas, yWas, zoomWas
    worldPosTo   = @worldPosFromCameraPos x, y, zoom

    @locked = true
    @camera.offset.x = @camera.offset.y = 0

    @tween.stop() if @tween
    if options.tween == false
      @cameraFixed()
      app.locked = false
      return

    @tween = new TWEEN.Tween(x: xWas, y: yWas, zoom: zoomWas)
      .to({ x: x, y: y, zoom: zoom }, 500)
      .easing(TWEEN.Easing.Cubic.InOut)
      .onUpdate ->
        app.cameraFixed @x, @y, @zoom
      .onComplete ->
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
    worldPos = @worldPosFromCameraPos()
    @world.position.x = worldPos.x
    @world.position.y = worldPos.y
    @shapeWorld.translation.set worldPos.x, worldPos.y

  onAssetLoaded: (loaderArgs, circlesArgs, mushiesArgs) ->
    @subview('panel').render().$el.appendTo $('body')
