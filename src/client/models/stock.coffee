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
    assumedCircle = @get('circle')
    return unless assumedCircle?

    quantity = @get('quantity')
    return if quantity <= 0

    circle = new Circle(assumedCircle.toJSON(), @get('item.ttl'))

    quantity -= 1
    @trigger 'use', @, circle, quantity
    # TODO: saveする
    if quantity <= 0
      @destroy()
    else
      @set quantity: quantity
