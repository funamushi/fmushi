Q = require 'q'
_ = require 'lodash'

{Breed} = require '../models'

exports.JSONFor = (user) ->
  Q.all([
    Breed.findAll(order: 'number')
    user.getBookPages()
  ])
  .then (results) ->
    breeds    = results[0]
    bookPages = results[1]
    _.map breeds, (breed) ->
      hasPage = _.find(bookPages, (bookPage) -> bookPage.breedId is breed.id)
      if hasPage
        JSON.stringify breed
      else
        { number: breed.number }

exports.defaultJSON = ->
  Breed.findAll(order: 'number')
  .then (breeds) ->
    _.map breeds, (breed) -> { number: breed.number }
    