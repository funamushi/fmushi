Fmushi   = require 'fmushi'
BaseView = require 'views/base'

module.exports = class CircleView extends BaseView
  colors:
    red:
      lineColor: '#F4D6E0'
      fillColor: '#DE7699'
      colorMatrix: [
        3,0,0,0
        0,1,0,0
        0,0,1,0
        0,0,0,1
      ]
    blue:
      lineColor: '#CCE9F9'
      fillColor: '#4CBAEB'
      colorMatrix: [
        1,0,0,0
        0,1,0,0
        0,0,2,0
        0,0,0,1
      ]
    green:
      lineColor: '#D6E9C9'
      fillColor: '#72C575'
      colorMatrix: [
        1,0,0,0
        0,3,0,0
        0,0,1,0
        0,0,0,1
      ]

  initialize: (options) ->
    model = @model
    attrs = model.toJSON()

    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r

    @defaultRadius = attrs.r

    if ttl = @model.ttl
      new TWEEN.Tween(r: 10)
      .to(r: @defaultRadius, 1600)
      .onUpdate ->
        model.set r: @r
      .easing(TWEEN.Easing.Exponential.InOut)
      .onComplete =>
        @model.updateExpiresAt()
        elapsed = 0

        @listenTo Fmushi.events, 'update', (delta) ->
          elapsed += delta
          shape.opacity = 1 - elapsed / ttl
      .start()
    else
      shape.opacity = 0.25

    if color = @colors[attrs.element]
      shape.stroke = color.lineColor
      shape.fill   = color.fillColor
      shape.linewidth = 3

    for v in @shape.vertices
      v.was = v.clone()

    @listenTo model, 'change',     @onChanged
    @listenTo model, 'collide',    @onCollision
    @listenTo model, 'circle:in',  @onAdded
    @listenTo model, 'circle:out', @onRemoved

    @lazyReset = _.debounce =>
      @reset()
    , 500

  onChanged: (circle) ->
    attrs = circle.toJSON()
    @shape.translation.set attrs.x, attrs.y
    if circle.hasChanged('r')
      @shape.scale = (attrs.r / @defaultRadius)

  onCollision: (entity, collisionPointWorld) ->
    r  = @model.get('r')
    r2 = r * r
    holdDistanceToSquared = Math.pow(r * 0.2, 2)

    collisionPointLocal = @localPositionAt(collisionPointWorld)
    vertices = @shape.vertices
    collideVertex = _.min vertices, (v) ->
      v.was.distanceToSquared(collisionPointLocal)

    unless collideVertex.tween?
      collideVertex.cid = entity.cid
      collideVertex.copy collisionPointLocal

    for v in vertices
      if collideVertex isnt v and !v.tween? and v.cid is entity.cid
        @reset(v)
   
  onAdded: (entity, count) ->
    @shape.linewidth = count * 2 + 3
    for v in @shape.vertices
      if v.cid is entity.cid
        @reset(v)

  onRemoved: (entity, count) ->
    @shape.linewidth = count * 2 + 3
    for v in @shape.vertices
      if v.cid is entity.cid
        @reset(v)

  # TODO: 孫要素とかを考慮してない
  localPositionAt: (worldPos) ->
    t = @shape.translation
    { x: worldPos.x - t.x, y: worldPos.y - t.y }

  reset: (v) ->
    return if v.equals(v.was)
    v.tween?.stop()
    v.cid = null

    backPoint =
      x: v.was.x - (v.x - v.was.x) * 1.0
      y: v.was.y - (v.y - v.was.y) * 1.0

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
      v.tween = null

    v.tween = backTween.chain(boundTween).start()
