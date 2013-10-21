class Fmushi.Views.World extends Backbone.View
  initialize: ->
    circle = new Fmushi.Views.Circle
    walker = new Fmushi.Views.Walker

    @listenTo Fmushi.Events, 'update', @collisionDetection

  collisionDetection: ->
