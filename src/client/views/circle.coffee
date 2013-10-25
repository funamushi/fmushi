class Fmushi.Views.Circle extends Backbone.View
  initialize: ->
    @listenTo @model, 'collide', (other, collisionPoint) -> 
      console.log collisionPoint.toJSON()

    attrs = @model.attributes
    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r

    shape.linewidth = 1
    shape.noFill()
    
