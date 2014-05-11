_ = require 'lodash'

{User, Item} = require '../models'

config = require 'config'

exports.authorize = (req, res, next) ->
  next()

exports.login = (req, res) ->

exports.logout = (req, res) ->

exports.show = (req, res) ->
  if req.user?
    res.json req.user
  else if req.session.profile?
    profile      = req.session.profile
    iconUrl      = profile.photos[0].value
    iconUrlLarge = iconUrl.replace(/(_normal)(\..+?)$/, '_bigger$2')
    res.json
      name:         profile.username
      iconUrl:      iconUrl
      iconUrlLarge: iconUrlLarge
  else
    Item.findAll
      where: { slug: config.defaultItems }
    .then (items) ->
      res.json
        belongings:
          _.map(items, (item) -> { item: item, quantity: 1 })
