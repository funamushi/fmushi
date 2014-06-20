Book = require 'models/book'

module.exports = class Books extends Backbone.Collection
  model: Book
