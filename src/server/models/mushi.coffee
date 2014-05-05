module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Mushi',
    x:
      type: DataTypes.FLOAT
      defaultValue: 0
    y:
      type: DataTypes.FLOAT
      defaultValue: 0
    direction:
      type: DataTypes.ENUM
      values: ['left', 'right']
      allowNull: false
      defaultValue: 'left'
  ,
    tableName: 'mushies'

