passport = require 'passport'

{LocalStrategy} = require 'passport-local'

passport.use new LocalStrategy (username, password, done) ->
  done null, { provider: 'fmushi', id: 1, name: 'hadashiA' }

module.exports =
  api: require('./api')

  siginupForm: (req, res) ->
    res.render 'siginup'

  signinForm: (req, res) ->
    res.render 'signin'

  siginup: (req, res) ->
    res.send 'siginup'

  siginin: (req, res) ->
    res.send 'siginin'

  home: (req, res) ->
    res.render 'home'