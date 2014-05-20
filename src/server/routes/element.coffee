config = require 'config'

exports.index = (req, res) ->
  res.send config.elements