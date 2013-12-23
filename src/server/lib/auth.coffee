passport = require 'passport'

exports.initStrategy =  ->
  LocalStrategy = require('passport-local').Strategy
  
  passport.use new LocalStrategy(
    { usernameField: 'user[name]', passwordField: 'user[password]' },
    (username, password, done) ->
      done null, { id: 1, name: 'hadashiA' }
  )

exports.viewerAuthoirze = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.status(401).end()