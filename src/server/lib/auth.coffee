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