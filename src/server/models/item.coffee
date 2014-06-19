_ = require 'lodash'

config = require('config')

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Item',
    slug:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notNull: true
        notEmpty: true
        is: ['^[a-z-]+$']
    element:
      type: DataTypes.ENUM
      values: ['red', 'blue']
    ttl:
      type: DataTypes.INTEGER
  ,
    tableName: 'items'
    timestamps: false

    classMethods:
      findDefaults: ->
        slugs = _.keys(config.defaultItems)
        @findAll(where: { slug: slugs })

    getterMethods:
      name: ->
        config.items[@slug]?.name
        
