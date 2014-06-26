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

  set: (key, val, options) ->
    if typeof key is 'object'
      attrs = key
      options = val
    else
      (attrs = {})[key] = val

    if attrs.x?
      attrs.x = Math.min(Math.max(0, attrs.x), Fmushi.worldSize)

    if attrs.y?
      attrs.y = Math.min(Math.max(0, attrs.y), Fmushi.worldSize)

    if attrs.zoom?
      attrs.zoom = Math.min(Math.max(0.25, attrs.zoom), 5)

    super attrs, options

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
