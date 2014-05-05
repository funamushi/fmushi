Mushi = require 'models/mushi'
Breed = require 'models/breed'

module.exports = class Mushies extends Backbone.Collection
  model: Mushi

  addFromFetchSample: ->
    breed = new Breed
    breed.fetchSample().then =>
      @add breed: breed, x: 200, y: 300
      
    
