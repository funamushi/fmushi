class Fmushi.Models.Circle extends Backbone.Model
  defaults: ->
    x: 0
    y: 0
    r: 400

  initialize: ->
    @entityCids = {}

  pos: -> 
    new Fmushi.Vector @get('x'), @get('y')
  
  entityCount: ->
    _.size @entityCids

  collisionEntity: (entity) ->
    collisionPoint = null
    pos  = @pos()
    entityPos = { x: entity.get('x'), y: entity.get('y') }

    r  = @get('r')
    entityR = entity.get('r')

    distance2 = Math.abs pos.distanceToSquared(entityPos)

    # 中にいる場合
    if @haveEntity entity
      return if distance2 <= Math.pow(r - entityR, 2)
      
      # 外に移動してたらremove
      if distance2 > Math.pow(r + entityR * 0.7, 2)
        @removeEntity(entity)
      else
        diff = new Fmushi.Vector(pos.x - entityPos.x, pos.y - entityPos.y)
        collisionPoint = diff.normalize().multiplyScalar(-entityR).addSelf(entityPos)

    # 外にいる場合
    else
      return if distance2 >= Math.pow(r + entityR, 2)

      # 中に移動してたらadd
      if distance2 < Math.pow(r - (entityR * 0.7), 2)
        @addEntity(entity)
      else
        diff = new Fmushi.Vector(pos.x - entityPos.x, pos.y - entityPos.y)
        collisionPoint = diff.normalize().multiplyScalar(entityR).addSelf(entityPos)
  
    if collisionPoint
      @trigger 'circle:collide', entity, collisionPoint

  addEntity: (entity) ->
    return if @haveEntity(entity)
    @entityCids[entity.cid] = true
    @trigger 'circle:add'

  removeEntity: (entity) ->
    return unless @haveEntity(entity)
    delete @entityCids[entity.cid]
    @trigger 'circle:remove'

  haveEntity: (entity) ->
    !!@entityCids[entity.cid]

class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle
