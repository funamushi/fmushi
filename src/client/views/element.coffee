config = require 'config'

module.exports =
  index: (req, res) ->
    req.send config.elements