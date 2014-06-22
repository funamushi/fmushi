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

    @listenTo owner, 'change:camera', @onCameraChanged
    # if wildMushies?
    #   @listenTo wildMushies, 'add', @addwildMushi

  mapScale: ->
    @boxSize / @worldSize

  drawCameraBox: ->
    camera = @owner.get('camera')
    {x, y, zoom} = camera.attributes
    mapScale = @mapScale()
    windowSize = Fmushi.windowSize
    cameraWidth  = windowSize.w * mapScale
    cameraHeight = windowSize.h * mapScale

    cameraBox = @cameraBox
    cameraBox.clear()
    cameraBox.lineStyle 1, 0xf39c12
    cameraBox.drawRect(0, 0, cameraWidth, cameraHeight)
    cameraBox.position.x = x * mapScale - cameraWidth * 0.5
    cameraBox.position.y = y * mapScale - cameraHeight * 0.5

  addwildMushi: ->

  onWindowResize: ->
    windowSize = Fmushi.windowSize
    
    @box.position.x = windowSize.w - (@boxSize + @margin)
    @box.position.y = @margin

    @drawCameraBox()

  onCameraChanged: (camera) ->
    {x, y, zoom} = camera.attributes
    mapScale = @mapScale()
    windowSize = Fmushi.windowSize
    cameraWidth  = windowSize.w * mapScale
    cameraHeight = windowSize.h * mapScale

    cameraBox = @cameraBox
    cameraBox.position.x = x * mapScale - cameraWidth  * 0.5
    cameraBox.position.y = y * mapScale - cameraHeight * 0.5

  displace: ->
    super
    Fmushi.stage.removeChild @box
    $(window).unbind 'resize', @onWindowResizeDebounce