passport = require 'passport'

exports.authorize = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.status(401).end()

exports.signin = (req, res) ->
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
