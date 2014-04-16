Item = require 'models/item'

module.exports = class Equipment extends Backbone.Model
  relations: [
    {
      type: Backbone.One
      key: 'item'
      relatedModel: Item
    }
  ]
