class Fmushi.Views.Circle extends Fmushi.Views.Base
  initialize: ->
    attrs = @model.toJSON()
    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r
    shape.stroke = attrs.lineColor
    shape.fill   = attrs.fillColor
    shape.linewidth = 3
    Fmushi.scene.shapeWorld.add shape

    for v in @shape.vertices
      v.was = v.clone()

    @listenTo @model, 'circle:collide', @onCollision
    @listenTo @model, 'circle:add',     @onAdded
    @listenTo @model, 'circle:remove',  @onRemoved

    @canCollide = true

    @layyReset = _.debounce ( =>
      @reset()
    ), 100

  onCollision: (other, collisionPointWorld) ->
    return unless @canCollide

    r  = @model.get('r')
    r2 = r * r
    holdDistanceToSquared = Math.pow(r * 0.2, 2)

    collisionPointLocal = @localPositionAt(collisionPointWorld)
    vertices = @shape.vertices
    stretchVertex = _.min vertices, (v) ->
      v.distanceToSquared(collisionPointLocal)
    stretchVertex.copy collisionPointLocal

    @lazyReset()
   
  onAdded: (entity, count) ->
    @shape.linewidth = count * 2 + 3
    @reset()

  onRemoved: (entity, count) ->
    @shape.linewidth = count * 2 + 3
    @reset()

  # TODO: 孫要素とかを考慮してない
  localPositionAt: (worldPos) ->
    t = @shape.translation
    { worldPos.x - t.x, worldPos.y - t.y }

  reset: ->
    that = this
    that.canCollide = false
    promises = []
    _.each @shape.vertices, (v) -> 
      unless v.equals(v.was)
        v.tween?.stop()
        backPoint =
          x: v.was.x - (v.x - v.was.x) * 1.0
          y: v.was.y - (v.y - v.was.y) * 1.0

        d = $.Deferred()
        backTween = new TWEEN.Tween(x: v.x, y: v.y)
          .to({ x: backPoint.x, y: backPoint.y}, 125)
          .onUpdate ->
            v.set @x, @y
          .easing(TWEEN.Easing.Bounce.InOut)

        boundTween = new TWEEN.Tween(x: backPoint.x, y: backPoint.y)
          .to({ x: v.was.x, y: v.was.y }, 550)
          .easing(TWEEN.Easing.Bounce.Out)
          .onUpdate ->
            v.set @x, @y
          .onComplete ->
            d.resolve()

        v.tween = backTween.chain(boundTween).start()
        promises.push d.promise()

    $.when.apply($, promises).done ->
      that.canCollide = true
