passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy

config = require('config').twitter

db = require '../models'
{User, Identity} = db

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  User.find(id)
  .then (user) ->
    done null, user
  .catch (err) ->
    done err

passport.use new TwitterStrategy
  consumerKey:    config.consumerKey
  consumerSecret: config.consumerSecret
  callbackURL:    config.callbackURL
  passReqToCallback: true
, (req, token, tokenSecret, profile, done) ->
  Identity
  .find(
    where: { uid: profile.id, provider: 'twitter' }
    include: [User]
  )
  .then (identity) ->
    if identity?
      done null, identity.user
    else
      req.session.profile = profile
      done null, false
  .catch (err) ->
    done err
