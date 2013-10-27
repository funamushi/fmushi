class Fmushi.Views.World extends Backbone.View
  debug: true

  initialize: ->
    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    loader = new PIXI.AssetLoader ['/app.json']
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

    @mushies.add [{ x: 100, y: 100 }]
    @mushies.add [{ x: 200, y: 200 }]
    @mushies.add [{ x: 300, y: 300 }]

    @circles.add [{ x: 500, y: 500, r: 300 }]

  collisionDetection: ->
    mushies = @mushies

    @circles.each (circle) ->
      mushies.each (mushi) ->
        circle.collisionEntity mushi
      