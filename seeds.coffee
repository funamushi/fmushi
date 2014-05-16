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
      Item.findOrCreate({ slug: slug }, attrs, { transaction: t }).then ->
        console.log "item #{slug} #{JSON.stringify attrs}"
    )

  _.each config.breeds, (properties, slug) ->
    attrs = {}
    promises.push(
      Breed.findOrCreate({ slug: slug }, attrs, { transaction: t}).then ->
        console.log "breed #{slug} #{JSON.stringify attrs}"
    )
      
  Q.all(promises).then ->
    t.commit().then ->
      process.exit()
