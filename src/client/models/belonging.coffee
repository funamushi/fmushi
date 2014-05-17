Item   = require 'models/item'
Circle = require 'models/circle'

module.exports = class Belonging extends Backbone.AssociatedModel
  defaults:
    quantity: 1

  relations: [
    {
      type: Backbone.One
      key: 'item'
      relatedModel: Item
    }
  ]

  use: ->
    item = @get('item')
    new Circle(color: 'red')