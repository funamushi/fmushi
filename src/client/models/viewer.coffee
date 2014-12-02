User    = require 'models/user'
Camera  = require 'models/camera'
Breed   = require 'models/breed'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'
Stocks  = require 'collections/stocks'

module.exports = class Viewer extends User
  url: ->
    '/viewer'
