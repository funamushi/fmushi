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
      console.log circle
      @set circle: null
      @trigger 'close', @, circle
