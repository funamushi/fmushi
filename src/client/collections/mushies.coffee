Fmushi = require 'fmushi'
Mushi  = require 'models/mushi'
Breed  = require 'models/breed'

module.exports = class Mushies extends Backbone.Collection
  model: Mushi

  addFromFetchSample: ->
    size = Fmushi.screenSize
    breed = new Breed
    breed.fetchSample().then =>
      @add breed: breed, x: size.w, y: _.random(size.h * 0.5, size.h * 0.9)
      
    
