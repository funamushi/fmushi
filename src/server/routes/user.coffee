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
  res.render 'signup', profile: req.session.profile

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send JSON.stringify(req.user)

exports.mushi = (req, res) ->
  res.render 'index'
