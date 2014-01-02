class Fmushi.Scenes.Home extends Fmushi.Scenes.Base
  defaultZoom: 0.5

  initialize: (options) ->
    @owner = owner =
      if options.userName is Fmushi.viewer.get('name')
        Fmushi.viewer
      else
        new Fmushi.Models.User name: options.userName

    @mushies = new Fmushi.Collections.Mushies [], user: owner
    @circles = new Fmushi.Collections.Circles [], user: owner
    @camera  = new Fmushi.Models.Camera {}, user: owner

    @locked = false

    @listenTo @camera, 'change', @onCameraChanged
    @listenTo @circles, 'add', @addEntity
    @listenTo @mushies, 'add', @addEntity
    @listenTo @mushies, 'change', @collisionDetection

    @listenTo Fmushi.router, 'route:home', (userName) ->
      @focusOut()

    @listenTo Fmushi.router, 'route:mushi', (userName, mushiId) ->
      @focus mushiId

    # subviews
    panelView = new Fmushi.Views.MushiesPanel
      user: owner
      collection: @mushies
    @subview 'panel', panelView

    dialogView = new Fmushi.Views.MushiDialog
    @subview 'dialog', dialogView

    @initDrag()
    @fetch().then => 
      @effects = new Fmushi.EffectsManager

      add = _.bind @addEntity, @
      @circles.each add
      @mushies.each add
      @subview('panel').render()

      if options.focusMushiId?
        @focus options.focusMushiId
      else
        center = Fmushi.screenCenter()
        @camera.set
          x: center.x
          y: center.y
          zoom: @defaultZoom

  fetch: -> 
    promises = [
      @circles.fetch(silent: true)
      @mushies.fetch(silent: true)
    ]
    promises.push @owner.fetch(silent: true) if @owner.isNew()
    $.when.apply($, promises).done =>
      @trigger 'load:complete'

  initDrag: ->
    stage = Fmushi.stage
    stage.mousedown = stage.touchstart = (e) =>
      if !@focusEntity or !@hitTestFromEntity(@focusEntity, e)
        @lastDragPoint = e.global

    stage.mousemove = stage.touchmove = (e) =>
      if @lastDragPoint and !@focusEntity
        x = e.global.x
        y = e.global.y
        diffX = @lastDragPoint.x - x
        diffY = @lastDragPoint.y - y
        @camera.set(
          { x: @camera.get('x') + diffX, y: @camera.get('y') + diffY },
          { tween: false }
        )
        @lastDragPoint = { x: x, y: y }

    stage.mouseup = stage.mouseupoutside = stage.touchend = stage.touchendoutside = (e) =>
      if @lastDragPoint
        if @focusEntity?
          Backbone.history.navigate @owner.url(), trigger: true
        @lastDragPoint = null

    $canvas = $(Fmushi.renderer.view)
    $canvas.on 'mousewheel', (e) =>
      x = @camera.get('x')
      y = @camera.get('y')
      @camera.set { x: x + e.deltaX, y: y - e.deltaY }, { tween: false }

  dragCancel: ->
    @lastDragPoint = null    

  collisionDetection: (mushi) ->
    @circles.each (circle) ->
      circle.collisionEntity mushi

  worldPosFromCameraPos: (x, y, zoom) ->
    camera = @camera
    x ?= camera.get('x')
    y ?= camera.get('y')
    zoom ?= camera.get('zoom')

    center = Fmushi.screenCenter()
    worldPosX = -(x * zoom - center.x)
    worldPosY = -(y * zoom - center.y)
    { x: worldPosX, y: worldPosY }

  worldPosFromScreenPos: (x, y) ->
    if !y? and typeof x is 'object'
      y = x.y
      x = x.x
    center  = Fmushi.screenCenter()
    zoom    = @camera.get('zoom')
    offsetX = @camera.get('x') - (center.x / zoom)
    offsetY = @camera.get('y') - (center.y / zoom)
    { x: (x / zoom) + offsetX, y: (y / zoom) + offsetY }

  addEntity: (model) ->
    view = 
      if model instanceof Fmushi.Models.Mushi
        new Fmushi.Views.Mushi model: model
      else if model instanceof Fmushi.Models.Circle
        new Fmushi.Views.Circle model: model

    @subview model.cid, view if view?

  entity: (model) ->
    @subview model.cid

  hitTestFromEntity: (model, e) ->
    view = @subview model.cid
    view? and Fmushi.stage.interactionManager.hitTest(view.sprite, e)

  focus: (entityOrId) ->
    entity = @mushies.get(entityOrId)
    return if @focusEntity is entity

    @camera.set
      x: entity.get('x')
      y: entity.get('y')
      zoom: 2
    
    dialog = @subview('dialog')
    dialog.open entity

    @focusEntity = entity
    @listenTo entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:in', entity

  focusOut: ->
    return unless @focusEntity

    entity = @focusEntity
    @focusEntity = null
    @camera.set zoom: @defaultZoom

    @subview('dialog').close()

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

  onCameraChanged: (camera = @camera, options = {}) ->
    return if @locked

    x    = camera.get 'x'
    y    = camera.get 'y'
    zoom = camera.get 'zoom'
    xWas    = camera.previous('x') or x
    yWas    = camera.previous('y') or y
    zoomWas = camera.previous('zoom') or zoom
    
    worldPosFrom = @worldPosFromCameraPos xWas, yWas, zoomWas
    worldPosTo   = @worldPosFromCameraPos x, y, zoom

    @locked = true
    @camera.offset.x = @camera.offset.y = 0

    @tween.stop() if @tween
    if options.tween == false
      @cameraFixed()
      @locked = false
      return

    scene = @
    @tween = new TWEEN.Tween(x: xWas, y: yWas, zoom: zoomWas)
      .to({ x: x, y: y, zoom: zoom }, 500)
      .easing(TWEEN.Easing.Cubic.InOut)
      .onUpdate ->
        scene.cameraFixed @x, @y, @zoom
      .onComplete ->
        scene.locked = false
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
