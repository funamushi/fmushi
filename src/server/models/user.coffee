_ = require 'lodash'

config = require('config')

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'User',
    name:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notEmpty: true
        is: ['^[a-z_-]+$', 'i']
    displayName:
      type: DataTypes.STRING
    fp:
      type: DataTypes.INTEGER
      defaultValue: 0
      validate:
        min: 0
  ,
    tableName: 'users'

    getterMethods:
      bookItemsCount: ->
        _.size(config.breeds)
      