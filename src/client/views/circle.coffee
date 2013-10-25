class Fmushi.Views.Circle extends Backbone.View
  initialize: ->
    @listenTo @model, 'collide', (other) ->
      console.log other

    shape = Fmushi.two.makeCircle(
      Fmushi.two.width / 2,
      Fmushi.two.height / 2,
      Fmushi.two.height / 3
      )

    shape.linewidth = 1
    shape.noFill()
    
