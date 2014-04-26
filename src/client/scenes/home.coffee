Fmushi    = require 'fmushi'

User    = require 'models/user'
Camera  = require 'models/camera'
Mushi   = require 'models/mushi'
Circle  = require 'models/circle'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'

MushiView  = require 'views/mushi'
CircleView = require 'views/circle'

BaseScene        = require 'scenes/base'
MushiesPanelView = require 'views/mushies-panel'
MushiDialogView  = require 'views/mushi-dialog'

helpers = require 'helpers'

module.exports = class HomeScene extends BaseScene
  defaultZoom: 1

  initialize: (options) ->
    viewer = Fmushi.viewer
    @owner = owner =
      if options.userName? and options.userName isnt viewer.get('name')
        new User name: options.userName
      else
        viewer

    camera  = owner.get('camera')
    mushies = owner.get('mushies')
    circles = owner.get('circles')
    @locked = false

    @listenTo camera, 'change', @onCameraChanged
    @listenTo mushies, 'add', @addEntity
    @listenTo circles, 'add', @addEntity
    @listenTo mushies, 'change:y', @reorderZ

    @listenTo mushies, 'change', (mushi) ->
      circles.each (circle) ->
        circle.collisionEntity mushi

    # subviews
    unless Modernizr.touch
      panelView = new MushiesPanelView
        owner: owner
        collection: mushies
      @subview 'panel', panelView

    dialogView = new MushiDialogView
    @$el.append dialogView.render().el
    @subview 'dialog', dialogView

    @initDrag()

    mushies.each (mushi) =>
      @addEntity mushi
    circles.each (circle) =>
      @addEntity circle

    $body = $(document.body)
    if panel = @subview('panel')
      $body.append panel.render().el
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
    helpers.headerMessage 'toste'
    

  initDrag: ->
    @$canvas = $(Fmushi.renderer.view)
    camera = @owner.get('camera')

    lastDragPoint = null
    @$canvas
    .on 'click tap', (e) =>
      @focusOut() if @focusEntity

    .on 'swipe', (e) ->
      e.preventDefault()

      # if _.any(@subviewsByName, (subview, name) -> subview.gripped)
      #   return

      # if !@focusEntity and lastDragPoint
      #   center = e.gesture.center
      #   diffX = lastDragPoint.x - center.pageX
      #   diffY = lastDragPoint.y - center.pageY
      #   zoom = camera.get 'zoom'
      #   camera.set
      #     x: camera.get('x') + diffX / zoom
      #     y: camera.get('y') + diffY / zoom
      #   ,
      #     tween: false
      #   lastDragPoint.x = center.pageX
      #   lastDragPoint.y = center.pageY

    .on 'pinchIn', (e) ->
      e.preventDefault()
      
      # zoom = camera.get('zoom') - (0.03 * e.gesture.scale)
      # return if zoom < 0.01
      # camera.set { zoom: zoom }, { tween: false }

    .on 'pinchOut', (e) ->
      e.preventDefault()

      # zoom = camera.get('zoom') + (0.01 * e.gesture.scale)
      # return if zoom > 3
      # camera.set { zoom: zoom }, { tween: false }

    .on 'mousewheel', (e) ->
      e.preventDefault()

      x = camera.get('x')
      y = camera.get('y')
      camera.set { x: x + e.deltaX, y: y - e.deltaY }, { tween: false }

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

  addEntity: (model) ->
    klass =
      if model instanceof Mushi
        MushiView
      else if model instanceof Circle
        CircleView

    if klass?
      view = new klass(model: model)

      if view.sprite?
        @world.addChild view.sprite
      if view.shape?
        @shapeWorld.add view.shape
      @subview model.cid, view

  entity: (model) ->
    @subview model.cid

  focus: (entity) ->
    entity = @owner.get('mushies').get(entity)
    return if (not entity?) or @focusEntity is entity

    @owner.get('camera').set
      x: entity.get('x')
      y: entity.get('y')
      zoom: 2.5
    
    dialog = @subview('dialog')
    dialog.open entity

    @focusEntity = entity
    @listenTo entity, 'change', @onFocusEntityChanged
    entity.trigger 'focus:in', entity

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