module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Circle',
    x:
      type: DataTypes.FLOAT
      defaultValue: 0
    y:
      type: DataTypes.FLOAT
      defaultValue: 0
    r:
      type: DataTypes.FLOAT
      validate:
        notNull: true
        min: 0
    element:
      type: DataTypes.ENUM
      values: ['red', 'blue']
      validate:
        notNull: true
    expiresAt:
      type: DataTypes.DATE
      validate:
        notNull: true
  ,
    tableName: 'mushies'

