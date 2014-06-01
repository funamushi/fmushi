Item   = require 'models/item'
Circle = require 'models/circle'

module.exports = class Stock extends Backbone.AssociatedModel
  defaults:
    quantity: 1

  relations: [
    {
      type: Backbone.One
      key: 'item'
      relatedModel: Item
    }
    {
      type: Backbone.One
      key: 'circle'
      relatedModel: Circle
    }
  ]

  open: (x, y) ->
    circle = new Circle(x: x, y: y, element: @get('item.element'))
    @set circle: circle
    @trigger 'open', @, circle

  close: ->
    if circle = @get('circle')
      @set circle: null
      @trigger 'close', @, circle

  use: ->
    circle = @get('circle')
    return unless circle?

    quantity = @get('quantity')
    return if quantity <= 0

    quantity -= 1
    if quantity <= 0
      # @destroy() if quantity <= 0
    else
      @set quantity: quantity
      # TODO: saveする
    @trigger 'use', @, circle
