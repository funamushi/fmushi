class Fmushi.Views.App extends Backbone.View
  debug: true

  initialize: ->
    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world

    @camera = camera = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild camera

    camera.interactive = true
    camera.hitArea = Fmushi.stage.hitArea.clone()
    camera.click = (e) ->
      pos = e.getLocalPosition(camera)
      Fmushi.Events.trigger 'zoom', pos

    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = _.bind @onAssetLoaded, @, loader
    loader.load()

    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    @listenTo Fmushi.Events, 'zoom', @onZoomed

    @listenTo @mushies, 'add', (model) ->
      view = new Fmushi.Views.MushiWalking(model: model)
      @views[model.cid] = view

    @listenTo @circles, 'add', (model) ->
      view = new Fmushi.Views.Circle(model: model)
      @views[model.cid] = view

    @listenTo Fmushi.Events, 'update', @collisionDetection

  onAssetLoaded: (loader) ->
    @mushies.add [{ x: 700, y: 300 }]
    @mushies.add [{ x: 850, y: 400 }]
    @mushies.add [{ x: 1000, y: 500 }]

    @circles.add [{ x: 400, y: 350, r: 300 }]

  onZoomed: (pos) ->
    @camera.pivot.x = pos.x / (@camera.hitArea.width / 100)
    @camera.pivot.y = pos.y / (@camera.hitArea.height / 100)

    @camera.pos = pos

    @camera.scale.x *= 1.1
    @camera.scale.y *= 1.1

    console.log @camera.pivot

  # no implemented yet
  locationFromPosition: (worldPos) ->
    worldPos

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      