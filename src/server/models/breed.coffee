config = require('config').breeds

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Breed',
    number:
      type: DataTypes.INTEGER
      validate:
        notNull: true
        isInt: true
        min: 1
    slug:
      type: DataTypes.STRING
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
  