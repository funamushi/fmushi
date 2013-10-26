class Fmushi.Models.Circle extends Backbone.Model
  defaults: ->
    x: 0
    y: 0
    r: 400

  pos: -> 
    new Fmushi.Vector @get('x'), @get('y')
  
  collisionEntity: (other) ->
    pos  = @pos()
    otherPos = { x: other.get('x'), y: other.get('y') }

    r  = @get('r')
    otherR = other.get('r')

    distance2 = pos.distanceToSquared(otherPos)

    # 衝突判定
    return if Math.abs(distance2) >= Math.pow(r + otherR, 2)

    # 中心にある程度近ければ無視
    return if distance2 < Math.pow(r * 0.2, 2)

    diff = new Fmushi.Vector(pos.x - otherPos.x, pos.y - otherPos.y)
    collisionPoint = diff.normalize().multiplyScalar(otherR).addSelf(otherPos)

    @trigger 'collide', other, collisionPoint

class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle
