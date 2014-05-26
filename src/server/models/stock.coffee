module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Stock',
    quantity:
      type: DataTypes.INTEGER
      defaultValue: 1
      validate:
        isInt: true
        min: 0
        max: 99
  ,
    tableName: 'stocks'
