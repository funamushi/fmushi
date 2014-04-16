Item = require 'models/item'

module.exports = class Items extends Backbone.Collection
  model: Item

  url: '/items'
