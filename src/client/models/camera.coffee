class Fmushi.Models.Camera extends Backbone.Model
  defaults:
    x: 0
    y: 0
    zoom: 1

  initialize: (options) ->
    @user = options.user
    @offset = { x: 0, y: 0 }

  validate: (attrs) ->
    errors = []

    _.forEach ['x', 'y', 'zoom'], (name) ->
      value = attrs[name]
      if _.isNumber value
        if value < 0
          errors.push attr: name, message: '0未満にできません。'
        else if name is 'zoom'
          errors.push attr: 'zoom', message: '小さすぎます。' if value < 0.05
          errors.push attr: 'zoom', message: '大きすぎます。' if value > 2
      else
        errors.push attr: name, message: '数値ではありません。'

    return errors if errors.length

  clear: ->
    @offset.x = @offset.y = 0
