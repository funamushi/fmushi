passport = require 'passport'

LocalStrategy = require('passport-local').Strategy

dummyUser = { id: 1, name: 'hadashiA' }

passport.use new LocalStrategy (username, password, done) ->
  if password is 'hoge'
    done null, dummyUser
  else
    done null, false

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  done null, dummyUser

exports.authorize = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.status(401).end()

exports.register = (req, res) ->
  req.login dummyUser

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

exports.show = (req, res) ->
  res.format
    json: ->
      res.send req.user

    html: ->
      res.redirect "/#{req.user.name}"
