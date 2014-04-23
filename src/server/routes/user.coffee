exports.set = (req, res, next, userName) ->
  next()

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send {} # not implemented

exports.mushi = (req, res) ->
  res.render 'home'
