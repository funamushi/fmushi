module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Belonging',
    quantity:
      type: DataTypes.INTEGER
      defaultValue: 1
      validate:
        isInt: true
        min: 0
        max: 99
  ,
    tableName: 'belongings'
