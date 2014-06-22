Fmushi = require 'fmushi'

module.exports = class Camera extends Backbone.AssociatedModel
  defaults:
    x: 0
    y: 0
    zoom: 1

  initialize: (options) ->
    @offset = { x: 0, y: 0 }

  validate: (attrs) ->
    errors = []

    _.forEach ['x', 'y', 'zoom'], (name) ->
      value = attrs[name]
      if _.isNumber value
        if value < 0
          errors.push attr: name, message: '0未満にできません。'
      else
        errors.push attr: name, message: '数値ではありません。'

    return errors if errors.length

  clear: ->
    @offset.x = @offset.y = 0

  worldX: (clientX) ->
    center = Fmushi.windowCenter
    offsetX = @get('x') - center.x
    clientX + offsetX

  worldY: (clientY) ->
    center = Fmushi.windowCenter
    offsetY = @get('y') - center.y
    clientY + offsetY
