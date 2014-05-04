Mushi = require 'models/mushi'

module.exports = class Mushies extends Backbone.Collection
  model: Mushi

  optionalUrls:
    wild: '/mushies/wild'

  fetchWild: (options={}) ->
    options.url = @optionalUrls.wild
    @fetch(options)
    
