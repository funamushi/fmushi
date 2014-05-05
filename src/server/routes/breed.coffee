_ = require 'lodash'

{Breed} = require '../models'

config = require('config')

exports.sample = (req, res, next) ->
  slug = _.sample(Object.keys config.breeds)
  Breed.find
    where: { slug: slug }
  .then (breed) ->
    res.send JSON.stringify(breed)
  .catch (err) ->
    next err
