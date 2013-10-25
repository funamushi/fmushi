class Fmushi.Models.Circle extends Backbone.Model
  defaults: ->
    x: 0
    y: 0
    r: 400

  collisionEntity: (entity) ->
    # TODO: とりあえず円だけサポート
    radius      = @get('r')
    entityRadis = entity.get('r')

    center = new Two.Vector(@get('x'), @get('y'))
    entityCenter = new Two.Vector(entity.get('x'), entity.get('y'))

    if center.distanceToSquared(entityCenter) <= radius * radius + entityRadis * entityRadis
      console.log 'unko'
      @trigger 'cllide', entity

class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle
