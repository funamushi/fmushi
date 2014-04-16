Vector = require 'vector'

module.exports = class Circle extends Backbone.Model
  defaults: ->
    x: 0
    y: 0
    r: 400

  colors:
    hustle:
      lineColor: '#F4D6E0'
      fillColor: '#DE7699'
      colorMatrix: [
        3,0,0,0
        0,1,0,0
        0,0,1,0
        0,0,0,1
      ]
    rest:
      lineColor: '#D6E9C9'
      fillColor: '#72C575'
      colorMatrix: [
        1,0,0,0
        0,3,0,0
        0,0,1,0
        0,0,0,1
      ]
    walking:
      lineColor: '#CCE9F9'
      fillColor: '#4CBAEB'
      colorMatrix: [
        1,0,0,0
        0,1,0,0
        0,0,2,0
        0,0,0,1
      ]

  initialize: ->
    @entities = {}

  color: ->
    state = @get 'state'
    @colors[state]

  pos: ->
    new Vector(@get('x'), @get('y'))
  
  entityCount: ->
    _.size @entities

  collisionEntity: (entity) ->
    collisionPoint = null
    pos  = @pos()
    entityPos = { x: entity.get('x'), y: entity.get('y') }

    r  = @get('r')
    # TODO: 複数ボディに対応する
    entityR = entity.r

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
      @trigger 'circle:collide', entity, collisionPoint

  addEntity: (entity) ->
    return if @haveEntity(entity)
    @entities[entity.cid] = entity
    entity.circle = @
    @trigger 'circle:add', entity, _.size(@entities)

  removeEntity: (entity) ->
    return unless @haveEntity(entity)
    delete @entities[entity.cid]
    entity.circle = null
    @trigger 'circle:remove', entity, _.size(@entities)

  haveEntity: (entity) ->
    @entities[entity.cid]?
