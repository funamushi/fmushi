Fmushi   = require 'fmushi'
BaseView = require 'views/base'

module.exports = class UnchiView extends BaseView
  initialize: ->
    model = @model
    attrs = model.toJSON()
    @shape = shape = Fmushi.two.makeCircle attrs.x, attrs.y