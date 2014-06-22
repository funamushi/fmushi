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
    boxX = windowWidth - (@boxSize + @margin)
    boxY = @margin
    box.lineStyle 1, 0xf1c40f
    box.drawRect(boxX, boxY, @boxSize, @boxSize)
    Fmushi.stage.addChild box

    @onResize = _.debounce(_.bind(@updateWindow, @), 260)
    $window = $(window)
    $window.resize @onResize

    camera = owner.get('camera')
    {x, y, zoom} = camera.attributes
    mapScale = @mapScale()
    cameraWidth  = $window.width()  * mapScale
    cameraHeight = $window.height() * mapScale
    cameraX = x * mapScale - cameraWidth * 0.5
    cameraY = y * mapScale - cameraHeight * 0.5
    @cameraBox = cameraBox = new PIXI.Graphics
    cameraBox.lineStyle 1, 0xf39c12
    cameraBox.drawRect(cameraX + boxX, cameraY + boxY, cameraWidth, cameraHeight)
    box.addChild cameraBox

    # if wildMushies?
    #   @listenTo wildMushies, 'add', @addwildMushi

  mapScale: ->
    @boxSize / @worldSize

  updateWindow: ->
    windowWidth = Fmushi.windowSize.w
    @box.position.x = windowWidth - (@boxSize + @margin)
    @box.position.y = @margin

  updateCamera: ->
    

  addwildMushi: ->
    circle = Fmushi.two.makeCircle(0, 0, 2)
    circle.stroke = '#f1c40f'
    circle.fill = '#f1c40f'

    @shape.add circle

  displace: ->
    super
    Fmushi.stage.removeChild @box
    $(window).unbind 'resize', @onResize