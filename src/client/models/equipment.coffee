Fmushi = require 'fmushi'
Item   = require 'models/item'

module.exports = class Equipment extends Backbone.AssociatedModel
  relations: [
    {
      type: Backbone.One
      key: 'item'
      relatedModel: Item
      map: (itemId) ->
        Fmushi.items.get(itemId)
    }
  ]
