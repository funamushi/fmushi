module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Item',
    slug:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notNull: true
        notEmpty: true
        is: ['^[a-z-]+$']
  ,
    tableName: 'items'
    timestamps: false
