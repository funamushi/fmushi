passport = require 'passport'

LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy(
  { usernameField: 'user[name]', passwordField: 'user[password]' }
  (username, password, done) ->
    done null, { id: 1, name: 'hadashiA' }
)
