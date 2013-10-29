class Fmushi.Views.App extends Backbone.View
  initialize: ->
    app = @

    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world

    @camera = camera = new PIXI.Point(0, 0)
    
    @initMiniScreen()

    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = _.bind @onAssetLoaded, @, loader
    loader.load()

    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    @on 'camera:change', @onCameraChanged

    @listenTo @mushies, 'add', (model) ->
      view = new Fmushi.Views.MushiWalking(model: model)
      @views[model.cid] = view

    @listenTo @circles, 'add', (model) ->
      view = new Fmushi.Views.Circle(model: model)
      @views[model.cid] = view

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

    app = @
    camera = @camera
    graphics.click = graphics.tap = (e) ->
      pos = e.getLocalPosition(miniScreen)
      camera.x = (pos.x - (size.x / 2)) * (Fmushi.screenSize.x / size.y)
      camera.y = (pos.y - (size.y / 2)) * (Fmushi.screenSize.y / size.y)
      app.trigger 'camera:change', camera

  onCameraChanged: (camera, zoom)->
    @world.position.x = -camera.x
    @world.position.y = -camera.y

  onAssetLoaded: (loader) ->
    @mushies.add [{ x: 700, y: 300 }]
    @mushies.add [{ x: 850, y: 400 }]
    @mushies.add [{ x: 1000, y: 500 }]

    @circles.add [{ x: 400, y: 350, r: 300 }]

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      