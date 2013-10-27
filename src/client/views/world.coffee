class Fmushi.Views.World extends Backbone.View
  debug: true

  initialize: ->
    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    loader = new PIXI.AssetLoader ['./app.json']
    loader.onComplete = _.bind @onAssetLoaded, @, loader
    loader.load()

  onAssetLoaded: (loader) ->
    @listenTo @mushies, 'add', (model) ->
      view = new Fmushi.Views.MushiWalking(model: model)
      @views[model.cid] = view

    @listenTo @circles, 'add', (model) ->
      view = new Fmushi.Views.Circle(model: model)
      @views[model.cid] = view

    @listenTo Fmushi.Events, 'update', @collisionDetection

    @mushies.add [{ x: 700, y: 300 }]
    @mushies.add [{ x: 850, y: 400 }]
    @mushies.add [{ x: 1000, y: 500 }]

    @circles.add [{ x: 400, y: 350, r: 300 }]

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      