_ = require 'lodash'

{User, Item} = require '../models'

config = require 'config'

exports.register = (req, res) ->
  req.logout()
  req.login dummyUser, (err) ->
    res.render 'register'

exports.show = (req, res) ->
  Item.findAll
    where: { slug: config.defaultItems }
  .then (items) ->
    res.send
      belongings:
        _.map(items, (item) -> { item: item, quantity: 1 })
