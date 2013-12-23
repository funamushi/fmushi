passport = require 'passport'

exports.authorize = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.status(401).end()

exports.show = (req, res) ->
  res.send req.user
