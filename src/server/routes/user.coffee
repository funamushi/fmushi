sequelize = require '../models'
{User, Identity, Mushi, Breed, Belonging, Item} = sequelize

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
  profile = req.session.profile
  if not profile?
    # TODO error logging and response
    res.status 422
    res.end()
  else
    sequelize.transaction (t) ->
      user = null
      User.create({name: req.body.name}, transaction: t)
      .then (u) ->
        user = u
        identity = Identity.build
          provider: profile.provider
          uid:      profile.id
          nickname: profile.username
          token:    profile.token
          secret:   profile.secret
        user.addIdentity(identity, transaction: t)
      .then ->
        t.commit()
      .then ->
        req.logIn user, ->
          req.session.profile = null
          res.send JSON.stringify(req.user)
      .catch (err) ->
        # TODO err logging
        console.log err
        res.status 422
        res.end()

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send JSON.stringify(req.user)

exports.mushi = (req, res) ->
  res.render 'index'
