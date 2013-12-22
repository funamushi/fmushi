passport = require 'passport'

LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy (username, password, done) ->
  done null, { provider: 'fmushi', id: 1, name: 'hadashiA' }

module.exports =
  api: require('./api')

  siginupForm: (req, res) ->
    res.render 'siginup'

  signinForm: (req, res) ->
    res.render 'signin'

  signup: (req, res) ->
    res.send 'signup'

  signin: (req, res) ->
    res.send 'signin'

  home: (req, res) ->
    res.render 'home'