class Fmushi.Views.Circle extends Backbone.View
  initialize: ->
    circle = Fmushi.two.makeCircle(
      Fmushi.two.width / 2,
      Fmushi.two.height / 2,
      Fmushi.two.height / 3
      )

    circle.linewidth = 1
    circle.noFill()
