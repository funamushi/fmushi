module.exports = (sequelize, DataTypes) ->
  sequelize.define 'User',
    name:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notEmpty: true
        is: ['^[a-z_-]+$', 'i']
    fp:
      type: DataTypes.INTEGER
      defaultValue: 0
      validate:
        min: 0
  ,
    tableName: 'users'
