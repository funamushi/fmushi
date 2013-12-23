module.exports =
  user:  require './user'
  items: require './items'
  ranks: require './ranks'

  acceptOverride: (req, res, next, format) ->
    if format is 'json'
      req.headers.accept = "application/json"
    next()

  root: (req, res) ->
    res.render 'index'
