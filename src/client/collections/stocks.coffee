Stock = require 'models/stock'

module.exports = class Stocks extends Backbone.Collection
  model: Stock
