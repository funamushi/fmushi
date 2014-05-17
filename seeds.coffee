Q = require 'q'
_ = require 'lodash'

config = require 'config'

sequelize  = require './src/server/models'
{Item, Breed} = sequelize

sequelize.transaction (t) ->
  promises = []

  _.each config.items, (properties, slug) ->
    attrs = {}
    promises.push(
      Item.findOrCreate({ slug: slug }, attrs, { transaction: t })
    )

  _.each config.breeds, (properties, slug) ->
    attrs = {}
    promises.push(
      Breed.findOrCreate({ slug: slug }, attrs, { transaction: t})
    )
      
  Q.all(promises).then ->
    t.commit().then ->
      process.exit()
