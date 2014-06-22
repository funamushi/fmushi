Fmushi = require 'fmushi'
BaseView = require 'views/base'

module.exports = class MapView extends BaseView
  worldSize: 1500
  boxSize: 150
  margin:  20

  initialize: (options={}) ->
    @owner       = owner = options.owner
    @wildMushies = wildMushies = options.wildMushies

    windowWidth = Fmushi.windowSize.w

    @box = box = new PIXI.Graphics
    box.lineStyle 1, 0xf1c40f
    box.drawRect(0, 0, @boxSize, @boxSize)

    @onWindowResizeDebounce = _.debounce(_.bind(@onWindowResize, @), 260)
    $(window).resize @onWindowResizeDebounce

    @cameraBox = cameraBox = new PIXI.Graphics
    box.addChild cameraBox

    @onWindowResize()
    Fmushi.stage.addChild box

    @points = {}

    camera  = owner.get('camera')
    mushies = owner.get('mushies')
    @listenTo camera, 'change',  @onCameraChanged
    @listenTo mushies, 'add',    @onOwnMushiAdded
    @listenTo mushies, 'remove', @onMushiRemoved
    @listenTo mushies, 'change', @onMushiChanged
    if wildMushies?
      @listenTo wildMushies, 'add',    @onWildMushiAdded
      @listenTo wildMushies, 'remove', @onMushiRemoved
      @listenTo wildMushies, 'change', @onMushiChanged

  mapScale: ->
    @boxSize / @worldSize

  drawCameraBox: ->
    camera = @owner.get('camera')
    {x, y, zoom} = camera.attributes
    mapScale = @mapScale()
    windowSize = Fmushi.windowSize
    cameraWidth  = windowSize.w * mapScale / zoom
    cameraHeight = windowSize.h * mapScale / zoom

    cameraBox = @cameraBox
    cameraBox.clear()
    cameraBox.lineStyle 1, 0xf39c12
    cameraBox.drawRect(0, 0, cameraWidth, cameraHeight)
    cameraBox.position.x = x * mapScale - cameraWidth * 0.5
    cameraBox.position.y = y * mapScale - cameraHeight * 0.5

  onWindowResize: ->
    windowSize = Fmushi.windowSize
    
    @box.position.x = windowSize.w - (@boxSize + @margin)
    @box.position.y = @margin

    @drawCameraBox()

  onCameraChanged: (camera) ->
    if camera.hasChanged('zoom')
      @drawCameraBox()
    else
      {x, y, zoom} = camera.attributes
      mapScale = @mapScale()
      windowSize = Fmushi.windowSize
      cameraWidth  = windowSize.w * mapScale / zoom
      cameraHeight = windowSize.h * mapScale / zoom

      cameraBox = @cameraBox
      cameraBox.position.x = x * mapScale - cameraWidth  * 0.5
      cameraBox.position.y = y * mapScale - cameraHeight * 0.5

  onWildMushiAdded: (mushi) ->
    point = new PIXI.Graphics
    radius = 2
    point.beginFill(0xbdc3c7)
    point.drawCircle 0, 0, radius
    @box.addChild point
    @points[mushi.cid] = point

  onOwnMushiAdded: (mushi) ->
    point = new PIXI.Graphics
    radius = 2
    point.beginFill(0x16a085)
    point.drawCircle 0, 0, radius
    @box.addChild point
    @points[mushi.cid] = point

  onMushiRemoved: (mushi) ->
    point = @points[mushi.cid]
    console.log point
    @box.removeChild point

  onMushiChanged: (mushi) ->
    point = @points[mushi.cid]
    {x, y} = mushi.attributes
    mapScale = @mapScale()
    point.position.x = x * mapScale
    point.position.y = y * mapScale

  displace: ->
    super
    Fmushi.stage.removeChild @box
    $(window).unbind 'resize', @onWindowResizeDebounce
    