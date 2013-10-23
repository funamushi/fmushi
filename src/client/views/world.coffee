class Fmushi.Views.World extends Backbone.View
  initialize: ->
    @views = {}
    @mushies = new Fmushi.Collections.Mushies
    @circles = new Fmushi.Collections.Circles

    @listenTo @mushies, 'add', (model) ->
      view = new Fmushi.Views.MushiWalking(model: model)
      @views[model.cid] = view

    @listenTo @circles, 'add', (model) ->
      view = new Fmushi.Views.Circle(model: model)
      @views[model.cid] = view

    @listenTo Fmushi.Events, 'update', @collisionDetection

    @mushies.add [{ x: 100, y: 100 }]
    @circles.add [{ x: 300, y: 300, r: 300}]

  collisionDetection: ->
