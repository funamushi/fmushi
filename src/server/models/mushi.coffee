Sequelize = require 'Sequelize'
sequelize = require '../sequelize'

module.exports = sequelize.define 'Mushi',
  userId:
    type: DataTypes.INTEGER
    allowNull: false
    references: 'users'
    referencesKey: 'id'
  name:
    type: DataTypes.STRING
    allowNull: false
  x:
    type: DataTypes.FLOAT
    defaultValue: 0
  y:
    type: DataTypes.FLOAT
    defaultValue: 0
,
  tableName: 'mushies'
