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
  res.render 'index'

exports.create = (req, res) ->
  User.create(name: req.body.name)
  .then (user) ->
    req.logIn user, ->
      req.session.profile = null
      res.json JSON.stringify(req.user)
  .catch (err) ->
    # TODO err logging
    res.status 422

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.json JSON.stringify(req.user)

exports.mushi = (req, res) ->
  res.render 'index'
