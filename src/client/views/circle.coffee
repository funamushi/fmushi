class Fmushi.Views.Circle extends Fmushi.Views.Base
  initialize: ->
    attrs = @model.toJSON()
    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r
    shape.stroke = attrs.lineColor
    shape.fill   = attrs.fillColor
    shape.linewidth = 1
    Fmushi.app.shapeWorld.add shape

    for v in @shape.vertices
      v.was = v.clone()

    @listenTo @model, 'circle:collide', @onCollision
    @listenTo @model, 'circle:add',     @onAdded
    @listenTo @model, 'circle:remove',  @onRemoved

    @canCollide = true

  onCollision: (other, collisionPointWorld) ->
    return unless @canCollide

    r  = @model.get('r')
    r2 = r * r
    holdDistanceToSquared = Math.pow(r * 0.2, 2)

    collisionPointLocal = @localPositionAt(collisionPointWorld)
    vertices = @shape.vertices
    stretchVertex = _.min(vertices, (v) -> v.distanceToSquared(collisionPointLocal))
    stretchVertex.copy collisionPointLocal
   
  onAdded: (entity, count) ->
    @shape.linewidth = count + 1
    @reset()

  onRemoved: (entity, count) ->
    @shape.linewidth = count + 1
    @reset()

  # TODO: 孫要素とかを考慮してない
  localPositionAt: (worldPos) ->
    t = @shape.translation
    new Fmushi.Vector(worldPos.x - t.x, worldPos.y - t.y)

  reset: ->
    that = this
    that.canCollide = false
    promises = []
    _.each @shape.vertices, (v) -> 
      unless v.equals(v.was)
        v.tween.stop() if v.tween

        d = $.Deferred()
        v.tween = new TWEEN.Tween(x: v.x, y: v.y)
          .to({ x: v.was.x, y: v.was.y}, 500)
          .onUpdate ->
            v.set @x, @y
          .onComplete ->
            v.copy v.was
            d.resolve()
          .easing(TWEEN.Easing.Bounce.Out)
          .start()
        promises.push d.promise()

    $.when.apply($, promises).done ->
      that.canCollide = true
