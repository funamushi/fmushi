class Fmushi.Models.Circle extends Backbone.Model
  defaults: ->
    x: 0
    y: 0
    r: 400

  initialize: ->

  pos: -> 
    new Fmushi.Vector @get('x'), @get('y')
  
  collisionEntity: (other) ->
    pos  = @pos()
    otherPos = { x: other.get('x'), y: other.get('y') }

    r  = @get('r')
    otherR = other.get('r')

    return if pos.distanceToSquared(otherPos) > ((r * r) + (otherR * otherR))

    diff = pos.subSelf otherPos
    length = diff.length()

    collisionPoint = diff.normalize().multiplyScalar(length)

    @trigger 'cllide', other, collisionPoint

class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle
