{User, Identity, Mushi, Breed, Belonging, Item} = require '../models'

exports.set = (req, res, next, userName) ->
  User.find
    where: { name: userName }
    attributes: ['name', 'fp']
    include: [
      model: Identity, attributes: ['provider', 'nickname', 'url']
    ,
      model: Mushi, attributes: ['x', 'y', 'direction'], include: [
        model: Breed, attributes: ['slug']
      ]
    ,
      model: Belonging, attributes: ['quantity'], include: [
        model: Item, attributes: ['slug']
      ]
    ]
  .then (user) ->
    req.user = user
    next()
  .catch (err) ->
    next err

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send JSON.stringify(req.user)

exports.mushi = (req, res) ->
  res.render 'index'
