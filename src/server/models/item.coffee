config = require('config').items

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
    getterMethods:
      name: ->
        config[@slug]?.name
        
