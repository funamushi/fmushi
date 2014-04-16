Mushi = require 'models/mushi'

module.exports = class Fmushi.Collections.Mushies extends Backbone.Collection
  model: Mushi

  initialize: (models, options) ->
    @user = options.user

  url: ->
    @user.url() + '/mushies'

  set: (models, options) ->
    super models, options

    user = @user
    @each (model) ->
      model.user = user
