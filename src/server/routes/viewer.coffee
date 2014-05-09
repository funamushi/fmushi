_ = require 'lodash'

{User, Item} = require '../models'

config = require 'config'

exports.authorize = (req, res, next) ->
  next()

exports.logout = (req, res, next) ->
  next()

exports.show = (req, res) ->
  Item.findAll
    where: { slug: config.defaultItems }
  .then (items) ->
    res.send
      belongings:
        _.map(items, (item) -> { item: item, quantity: 1 })
