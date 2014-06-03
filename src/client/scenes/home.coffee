Fmushi = require 'fmushi'

User    = require 'models/user'
Camera  = require 'models/camera'
Mushi   = require 'models/mushi'
Circle  = require 'models/circle'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'

MushiView  = require 'views/mushi'
CircleView = require 'views/circle'

BaseScene        = require 'scenes/base'
MenuView         = require 'views/menu'
MushiDialogView  = require 'views/mushi-dialog'

helpers = require 'helpers'

module.exports = class HomeScene extends BaseScene
  defaultZoom: 1

  initialize: (options) ->
    viewer = Fmushi.viewer
    
    @wildMushies   = new Mushies
    @grippedCircle = null

    @listenTo @wildMushies, 'add',    @onAddWildMushi
    @listenTo @wildMushies, 'remove', @onRemoveWildMushi

    if options.userName? and options.userName isnt viewer.get('name')
      owner = new User name: options.userName
      owner.fetch().done =>
        @initOwner owner, options
    else
      @initOwner viewer, options
      unless viewer.loggedIn
        @tutorial()

  initOwner: (owner, options={}) ->
    @owner = owner

    camera  = owner.get('camera')
    mushies = owner.get('mushies')
    circles = owner.get('circles')
    stocks  = owner.get('stocks')
    @locked = false

    @listenTo camera,  'change',   @onCameraChanged
    @listenTo mushies, 'add',      @addEntity
    @listenTo mushies, 'change:y', @reorderZ
    @listenTo stocks,  'open',     @onStockOpen
    @listenTo stocks,  'close',    @onStockClose
    @listenTo stocks,  'use',      @onStockUse
    @listenTo circles, 'add',      @addEntity
    @listenTo circles, 'remove',   @removeEntity

    @listenTo @wildMushies, 'change', (mushi) ->
      circles.each (circle) ->
        circle.collisionEntity mushi

    # subviews
    menuView = new MenuView
      owner:        owner
      wildMushies:  @wildMushies
    @subview 'menu', menuView

    dialogView = new MushiDialogView
    @subview 'dialog', dialogView

    @initDrag()

    mushies.each (mushi) =>
      @addEntity mushi
    circles.each (circle) =>
      @addEntity circle

    $body = $(document.body)
    if menuView = @subview('menu')
      $body.append menuView.render().el
    $body.append @subview('dialog').render().el

    if options.focusMushiId?
      @focus options.focusMushiId
    else
      center = Fmushi.screenCenter()
      camera.set
        x: center.x
        y: center.y
        zoom: @defaultZoom

    @trigger 'ready'

  initDrag: ->
    @$canvas = $(Fmushi.renderer.view)
    camera = @owner.get('camera')

    lastDragPoint = null
    @hammer = Hammer(@$canvas[0])
    .on 'click', (e) =>
      @focusOut() if @focusEntity

    .on 'dragstart', (e) =>
      return if @grippedCircle?
      return if _.any(@subviewsByName, (subview, name) -> subview.gripped)

      lastDragPoint =
        x: e.gesture.center.pageX
        y: e.gesture.center.pageY

    .on 'drag', (e) =>
      return if @grippedCircle?

      if !@focusEntity? and lastDragPoint
        center = e.gesture.center
        diffX = lastDragPoint.x - center.pageX
        diffY = lastDragPoint.y - center.pageY
        zoom = camera.get 'zoom'
        camera.set
          x: camera.get('x') + diffX / zoom
          y: camera.get('y') + diffY / zoom
        ,
          tween: false
        lastDragPoint.x = center.pageX
        lastDragPoint.y = center.pageY

    .on 'dragend', (e) ->
      e.preventDefault()
      lastDragPoint = null

    .on 'pinchin', (e) ->
      e.preventDefault()
      
      zoom = camera.get('zoom') - (0.03 * e.gesture.scale)
      return if zoom < 0.01
      camera.set { zoom: zoom }, { tween: false }

    .on 'pinchout', (e) ->
      e.preventDefault()
      zoom = camera.get('zoom') + (0.01 * e.gesture.scale)
      return if zoom > 3
      camera.set { zoom: zoom }, { tween: false }

    @$canvas.on 'mousewheel', (e) ->
      x = camera.get('x')
      y = camera.get('y')
      camera.set { x: x + e.deltaX, y: y - e.deltaY }, { tween: false }

  tutorial: ->
    @wildMushies.addFromFetchSample()

  worldPosFromCameraPos: (x, y, zoom) ->
    camera = @owner.get('camera')
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

    camera = @owner.get('camera')
    zoom    = camera.get('zoom')
    offsetX = camera.get('x') - (center.x / zoom)
    offsetY = camera.get('y') - (center.y / zoom)
    { x: (x / zoom) + offsetX, y: (y / zoom) + offsetY }

  addEntity: (model, options={}) ->
    klass =
      if model instanceof Mushi
        MushiView
      else if model instanceof Circle
        CircleView

    if klass?
      options.model = model
      view = new klass(options)

      if view.sprite?
        @world.addChild view.sprite
      if view.shape?
        @shapeWorld.add view.shape
      @subview model.cid, view

  removeEntity: (model) ->
    view = @subview(model.cid)
    if view?
      if view.sprite?
        @world.removeChild view.sprite
      if view.shape?
        @shapeWorld.remove view.shape
      @removeSubview model.cid

  entity: (model) ->
    @subview model.cid

  focus: (entity) ->
    return if (not entity?) or @focusEntity is entity

    @owner.get('camera').set
      x: entity.get('x')
      y: entity.get('y')
      zoom: 2.5
    
    dialogView = @subview('dialog')
    dialogView.open entity

    @focusEntity = entity
    @listenTo entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:in', entity

    unless @owner.isNew()
      Backbone.history.navigate "#{@owner.url()}/mushies/#{entity.get 'id'}"

  focusOut: ->
    return unless @focusEntity

    entity = @focusEntity
    @focusEntity = null
    @owner.get('camera').set
      zoom: @defaultZoom

    @subview('dialog').close()

    @stopListening entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:out', entity

    unless @owner.isNew()
      Backbone.history.navigate @owner.url()

  cameraFixed: (x, y, zoom) ->
    camera     = @owner.get('camera')
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

  onCameraChanged: (camera, options = {}) ->
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
    camera.offset = { x: 0, y: 0}

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

    camera = @owner.get('camera')
    camera.offset ?= { x: 0, y: 0 }

    if prevX = entity.previous('x')
      camera.offset.x += (x - prevX)
    if prevY = entity.previous('y')
      camera.offset.y += (y - prevY)
    
    camera.set { x: x, y: y }, {silent: true}
    worldPos = @worldPosFromCameraPos()
    @world.position.x = worldPos.x
    @world.position.y = worldPos.y
    @shapeWorld.translation.set worldPos.x, worldPos.y

  onAddWildMushi: (mushi) ->
    helpers.headerMessage "野生の「#{mushi.get 'breed.name'}」が来ました。", duration: 5000
    @addEntity mushi, state: 'wild'

  onRemoveWildMushi: (mushi) ->
    @removeEntity mushi
    helpers.headerMessage "野生の「#{mushi.get 'breed.name'}」は行ってしまいました。",
      duration: 5000

  onStockOpen: (stock, circle) ->
    @grippedCircle = circle
    @addEntity circle

  onStockClose: (stock, circle) ->
    @grippedCircle = null
    @removeEntity circle

  onStockUse: (stock, circle) ->
    return unless circle?

    @removeEntity @grippedCircle
    @grippedCircle = null
    @owner.get('circles').add circle

  transitionOut: ->
    super()
    defer = $.Deferred()
    @owner.set
      camera:
        zoom: 0.01
    setTimeout ( -> defer.resolve() ), 1000
    defer.promise()

  reorderZ: ->
    @world.children = _.sortBy @world.children, (sprite) ->
      sprite.position.y

  dispose: ->
    super
    @$canvas.off()
    @hammer.dispose()
