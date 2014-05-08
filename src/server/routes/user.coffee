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

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'home'

    json: ->
      res.send JSON.stringify(req.user)

exports.mushi = (req, res) ->
  res.render 'home'
