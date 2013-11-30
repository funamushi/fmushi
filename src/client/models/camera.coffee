class Fmushi.Models.Camera extends Backbone.Model
  defaults:
    x: 0
    y: 0
    zoom: 1

  initialize: ->
    @offset = { x: 0, y: 0 }

  clear: ->
    @offset.x = @offset.y = 0
    
  add: (diffX, diffY) ->
    x = @get('x')
    y = @get('y')
    @set {x: x + diffX, y: y + diffY}, {tween: false}