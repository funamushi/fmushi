userSerializer = require '../serializers/user-serializer'

exports.authorize = (req, res, next) ->
  next()

exports.login = (req, res) ->

exports.logout = (req, res) ->

exports.show = (req, res) ->
  if req.user?
    userSerializer.toJSON(req.user).then (json) ->
      res.send json
  else if req.session.profile?
    profile      = req.session.profile
    iconUrl      = profile.photos[0].value
    iconUrlLarge = iconUrl.replace(/(_normal)(\..+?)$/, '_bigger$2')
    res.send
      name:         profile.username
      iconUrl:      iconUrl
      iconUrlLarge: iconUrlLarge
  else
    userSerializer.defaultJSON().then (json) ->
      res.send json
