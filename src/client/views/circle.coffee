class Fmushi.Views.Circle extends Backbone.View
  initialize: ->
    attrs = @model.attributes
    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r
    shape.linewidth = 1
    shape.noFill()
    
    for v in @shape.vertices
      v.was = v.clone()

    @listenTo @model, 'collide', @onCollision

    @canCollide = true

  onCollision: (other, collisionPointWorld) ->
    return unless @canCollide

    r  = @model.get('r')
    r2 = r * r
    holdDistanceToSquared = r2 * 0.3

    collisionPointLocal = @localPositionAt(collisionPointWorld)
    vertices = @shape.vertices
    stretchVertex = _.min(vertices, (v) -> v.distanceToSquared(collisionPointLocal))
    stretchVertex.copy collisionPointLocal

    if (@stretchVertex? and @stretchVertex != stretchVertex) or
       (Math.abs(stretchVertex.distanceToSquared(stretchVertex.was)) > holdDistanceToSquared)
      @stretchVertex = null
      @reset()
    else
      @stretchVertex = stretchVertex
      v.copy(v.was) for v in vertices when not v.equals(stretchVertex)
      if stretchVertex.tween
        stretchVertex.tween.stop()
        stretchVertex.tween = null

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
    
