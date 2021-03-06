Q = require 'q'
_ = require 'lodash'

config = require 'config'

sequelize  = require './src/server/models'
{Item, Breed} = sequelize

sequelize.transaction (t) ->
  promises = []

  _.each config.items, (props, slug) ->
    promise = Item.findOrBuild({ slug: slug }, transaction: t)
    .then (item) ->
      item[k] = v for k, v of props
      item.save(transaction: t)
    promises.push promise

  _.each config.breeds, (props, slug) ->
    promise = Breed.findOrBuild({ slug: slug, number: props.number }, transaction: t)
    .then (breed) ->
      breed[k] = v for k, v of props
      breed.save(transaction: t)
    promises.push promise
      
  Q.all(promises)
  .then ->
    t.commit()
  .catch (err) ->
    console.log err
  .fin ->
    process.exit()
