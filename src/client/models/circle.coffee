Fmushi = require 'fmushi'
Vector = require 'vector'

module.exports = class Circle extends Backbone.AssociatedModel
  defaults: ->
    x: 0
    y: 0
    r: 300

  initialize: (attrs, @ttl) ->
    @entities = {}

    if @ttl?
      @listenTo Fmushi.events, 'countdown', (now) =>
        expiresAt = @get('expiresAt')
        if expiresAt? and expiresAt <= now
          @stopListening(Fmushi.events)
          @destroy()

  entityCount: ->
    _.size @entities

  updateExpiresAt: ->
    expiresAt =
      if @ttl?
        timestamp = (new Date).valueOf()
        expiresAt = new Date(timestamp + (@ttl * 1000))
    @set expiresAt: expiresAt
    expiresAt

  collisionEntity: (entity) ->
    attrs = @attributes
    return unless @ttl?

    collisionPoint = null
    pos  = new Vector(attrs.x, attrs.y)
    entityPos = { x: entity.get('x'), y: entity.get('y') }

    r  = attrs.r
    # TODO: 複数ボディに対応する
    entityR = entity.radius()

    distance2 = Math.abs pos.distanceToSquared(entityPos)

    # 中にいる場合
    if @haveEntity entity
      return if distance2 <= Math.pow(r - entityR, 2)
      
      # 外に移動してたらremove
      if distance2 > Math.pow(r + entityR * 0.7, 2)
        @removeEntity(entity)
      else
        diff = new Vector(pos.x - entityPos.x, pos.y - entityPos.y)
        collisionPoint = diff
        .normalize()
        .multiplyScalar(-entityR)
        .addSelf(entityPos)

    # 外にいる場合
    else
      return if distance2 >= Math.pow(r + entityR, 2)

      # 中に移動してたらadd
      if distance2 < Math.pow(r - (entityR * 0.7), 2)
        @addEntity entity
      else
        diff = new Vector(pos.x - entityPos.x, pos.y - entityPos.y)
        collisionPoint = diff
        .normalize()
        .multiplyScalar(entityR)
        .addSelf(entityPos)
  
    if collisionPoint?
      @trigger 'collide', entity, collisionPoint

  addEntity: (entity) ->
    return if @haveEntity(entity)
    @entities[entity.cid] = entity
    @trigger 'circle:in', entity, _.size(@entities)
    entity.capture()

  removeEntity: (entity) ->
    return unless @haveEntity(entity)
    delete @entities[entity.cid]
    @trigger 'circle:out', entity, _.size(@entities)

  haveEntity: (entity) ->
    @entities[entity.cid]?
