_ = require 'lodash'

{User, Item} = require '../models'

config = require 'config'

exports.authorize = (req, res, next) ->
  next()

exports.login = (req, res) ->

exports.logout = (req, res) ->

exports.show = (req, res) ->
  if req.user?
    res.send JSON.stringify(req.user)
  else if req.session.profile?
    profile      = req.session.profile
    iconUrl      = profile.photos[0].value
    iconUrlLarge = iconUrl.replace(/(_normal)(\..+?)$/, '_bigger$2')
    res.send
      name:         profile.username
      iconUrl:      iconUrl
      iconUrlLarge: iconUrlLarge
  else
    slugs = _.keys(config.defaultItems)
    Item.findAll(where: { slug: slugs })
    .then (items) ->
      res.send
        stocks:
          _.map(items, (item) ->
            _.extend({item: item}, config.defaultItems[item.slug])
            )
