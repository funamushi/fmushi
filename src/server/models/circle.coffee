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
    expiresAt:
      type: DataTypes.DATE
      validate:
        notNull: true
  ,
    tableName: 'mushies'

