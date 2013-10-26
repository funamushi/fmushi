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

    return if pos.distanceToSquared(otherPos) > ((r * r) + (otherR * otherR))

    diff = new Fmushi.Vector(pos.x - otherPos.x, pos.y - otherPos.y)
    collisionPoint = diff.normalize().multiplyScalar(otherR).addSelf(otherPos)

    @trigger 'collide', other, collisionPoint

class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle
