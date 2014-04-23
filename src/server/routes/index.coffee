module.exports =
  viewer: require './viewer'
  user:   require './user'
  items:  require './items'

  acceptOverride: (req, res, next, format) ->
    if format is 'json'
      req.headers.accept = "application/json"
    next()

  root: (req, res) ->
    res.render 'index'
