module.exports = exports = class Vector extends Two.Vector
  toJSON: ->
    { x: @x, y: @y }

exports.vec2 = (x, y) ->
  new Vector(x, y)
