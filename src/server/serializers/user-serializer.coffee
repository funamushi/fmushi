_ = require 'lodash'
Q = require 'q'

config = require 'config'

{User, Item} = require '../models'
bookPagesSerializer = require './book-pages-serializer'

exports.toJSON = (user) ->
  json = JSON.stringify(user)
  bookPagesSerializer.JSONFor(user).then (book) ->
    json.book = book
    json

exports.defaultJSON = ->
  user = User.build()
  json = user.toJSON()

  Q.all([
    Item.findDefaults()
    bookPagesSerializer.defaultJSON()
  ]).then (results) ->
    items     = results[0]
    bookPages = results[1]

    json.stocks = _.map(items, (item) ->
      {
        item: item.toJSON()
        quantity: config.defaultItems[item.slug]
      }
    )
    json.bookPages = bookPages
    json
