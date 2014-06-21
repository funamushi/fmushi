_ = require 'lodash'
Q = require 'q'

config = require 'config'

{User, Item} = require '../models'
bookSerializer = require './book-serializer'

exports.toJSON = (user) ->
  json = JSON.stringify(user)
  bookSerializer.JSONFor(user).then (book) ->
    json.book = book
    json

exports.defaultJSON = ->
  user = User.build()
  json = user.toJSON()

  Q.all([
    Item.findDefaults()
    bookSerializer.defaultJSON()
  ]).then (results) ->
    items    = results[0]
    bookJSON = results[1]

    json.stocks = _.map(items, (item) ->
      {
        item: item.toJSON()
        quantity: config.defaultItems[item.slug]
      }
    )
    json.book = bookJSON
    json
