_        = require 'lodash'
passport = require 'passport'

LocalStrategy = require('passport-local').Strategy

{User, Item} = require '../models'

config = require 'config'

exports.authorize = (req, res, next) ->
  # if req.isAuthenticated()
  #   next()
  # else
  #   res.status(401).end()
  next()

exports.register = (req, res) ->
  req.logout()
  req.login dummyUser, (err) ->
    res.format
      json: ->
        res.send dummyUser

      html: ->
        res.render 'index'

exports.login = (req, res) ->
  res.format
    json: ->
      res.send req.user

    html: ->
      res.render 'index'

exports.logout = (req, res) ->
  req.logout()

  res.format
    json: ->
      res.send {}

    html: ->
      res.redirect '/'

exports.show = (req, res) ->
  Item.findAll
    where: { slug: config.defaultItems }
  .then (items) ->
    res.send
      belongings:
        _.map(items, (item) -> { item: item, quantity: 1 })
