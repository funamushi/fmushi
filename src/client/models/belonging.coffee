Item   = require 'models/item'

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
    