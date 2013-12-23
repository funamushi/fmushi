passport = require 'passport'

LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy (username, password, done) ->
  done null, { provider: 'fmushi', id: 1, name: 'hadashiA' }

module.exports =
  user:  require './user'
  items: require './items'
  ranks: require './ranks'

  acceptOverride: (req, res, next, format) ->
    if format is 'json'
      req.headers.accept = "application/json"
    next()

  root: (req, res) ->
    res.render 'index'
