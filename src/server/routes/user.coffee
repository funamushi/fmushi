{User, Identity, Mushi, Breed, Belonging, Item} = require '../models'

exports.set = (req, res, next, userName) ->
  User.findWithAssociations(name: userName)
  .then (user) ->
    if user?
      req.user = user
      next()
    else
      res.format
        html: ->
          res.status(404).send("#{userName} not exists.")
        json: ->
          res.status(404).send("#{userName} not exists.")
  .catch (err) ->
    next err

exports.new = (req, res) ->
  profile = req.session.profile
  console.log req.session.profile
  icon_url = profile.photos[0].value.replace(/(_normal)(\..+?)$/, '_bigger$2')

  res.render 'signup',
    name:     profile.username
    icon_url: icon_url

exports.create = (req, res) ->
  

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send JSON.stringify(req.user)

exports.mushi = (req, res) ->
  res.render 'index'
