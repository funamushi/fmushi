passport = require 'passport'

LocalStrategy = require('passport-local').Strategy

exports.authorize = (req, res, next) ->
  # if req.isAuthenticated()
  #   next()
  # else
  #   res.status(401).end()
  next()

exports.register = (req, res) ->
  req.logout()
  req.login dummyUser, (err) ->
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

exports.logout = (req, res) ->
  req.logout()

  res.format
    json: ->
      res.send {}

    html: ->
      res.redirect '/'

exports.show = (req, res) ->
  res.send {
    name: 'hadashiA'
    mushies: [
      {
        id: 1
        name: 'ヘイプー大佐'
        x: 200
        y: 200
      }
      {
        id: 2
        name: 'ミニマム級チャンピオン ワンツーぷや夫'
        x: 500
        y: 200
      }
      {
        id: 3
        name: 'プヤプヤプンヤ代表取締役'
        x: 700
        y: 200
      }
    ]
    circles: [
      {
        id: 1
        x: 700
        y: 650
        r: 200
      }
    ]
  }
