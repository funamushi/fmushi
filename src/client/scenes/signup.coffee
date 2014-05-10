BaseScene = require 'scenes/base'

module.exports = class SignupScene extends BaseScene
  initialize: (options) ->
    @trigger 'ready'
