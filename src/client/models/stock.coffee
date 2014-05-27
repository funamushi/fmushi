Item   = require 'models/item'

module.exports = class Stock extends Backbone.AssociatedModel
  defaults:
    quantity: 1

  relations: [
    {
      type: Backbone.One
      key: 'item'
      relatedModel: Item
    }
  ]

  open: ->
    @trigger 'open', @
