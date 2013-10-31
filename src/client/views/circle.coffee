class Fmushi.Views.Circle extends Backbone.View
  initialize: ->
    attrs = @model.attributes
    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r
    shape.linewidth = 1
    shape.noFill()
    Fmushi.app.shapeWorld.add shape

    for v in @shape.vertices
      v.was = v.clone()

    @listenTo @model, 'circle:collide', @onCollision
    @listenTo @model, 'circle:add',     @onAdded
    @listenTo @model, 'circle:remove',  @onRemoved

    @canCollide = true

  setRandomColor: ->
    colors = [
      #F4D6E0'
      '#DE7699'
      '#CCE9F9'
      '#4CBAEB'
      '#D6E9C9'
      '#72C575'
      '#F9F4D6'
      '#F7D663'
    ]
    @shape.stroke = colors[_.random(colors.length - 1)]

  onCollision: (other, collisionPointWorld) ->
    return unless @canCollide

    r  = @model.get('r')
    r2 = r * r
    holdDistanceToSquared = Math.pow(r * 0.2, 2)

    collisionPointLocal = @localPositionAt(collisionPointWorld)
    vertices = @shape.vertices
    stretchVertex = _.min(vertices, (v) -> v.distanceToSquared(collisionPointLocal))
    stretchVertex.copy collisionPointLocal
   
  onAdded: (entity) ->
    @updateLine()
    @reset()

  onRemoved: (entity) ->
    @updateLine()
    @reset()

  updateLine: ->
    size = @model.entityCount()

    strokeColors = [
      '#F7D663'
      '#72C575'
      '#4CBAEB'
      '#DE7699'
    ]

    fillColors = [
      '#F9F4D6'
      '#D6E9C9'
      '#CCE9F9'
      '#F4D6E0'
    ]

    if size == 0
      @shape.linewidth = 1
      @shape.stroke = 'black'
      @shape.noFill()
    else
      @shape.linewidth = size + 1
      @shape.stroke = strokeColors[size % strokeColors.length]
      @shape.fill = fillColors[size % fillColors.length]

  # TODO: 孫要素とかを考慮してない
  localPositionAt: (worldPos) ->
    t = @shape.translation
    new Fmushi.Vector(worldPos.x - t.x, worldPos.y - t.y)

  resetAt: (index) ->
    v = @shape.vertices[index]
    return unless v?

    v.tween.stop() if v.tween
    v.tween = new TWEEN.Tween(x: v.x, y: v.y)
      .to({ x: v.was.x, y: v.was.y}, 500)
      .easing(TWEEN.Easing.Bounce.Out)
      .onUpdate ->
        v.set @x, @y
      .onComplete -> 
        v.copy v.was
        v.tween = null
      .start()

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
    
