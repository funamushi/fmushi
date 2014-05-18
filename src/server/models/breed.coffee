config = require('config').breeds

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Breed',
    slug:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notNull: true
        notEmpty: true
        is: ['^[a-z-]+$']
    element:
      type: DataTypes.ENUM
      values: ['red', 'blue', 'green', 'yellow']
  ,
    tableName: 'breeds'
    timestamps: false
    getterMethods:
      name: ->
        config[@slug]?.name
  