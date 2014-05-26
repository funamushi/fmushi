module.exports = (sequelize, DataTypes) ->
  {Item, Breed, Identity, Mushi, Stock} = sequelize

  sequelize.define 'User',
    name:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notEmpty: true
        is: ['^[a-z_-]+$', 'i']
    displayName:
      type: DataTypes.STRING
    fp:
      type: DataTypes.INTEGER
      defaultValue: 0
      validate:
        min: 0
  ,
    tableName: 'users'
