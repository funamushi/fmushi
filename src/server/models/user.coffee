Sequelize = require 'sequelize'
sequelize = require '../sequelize'

module.exports = sequelize.define 'User',
  fp:
    type: Sequelize.INTEGER
    defaultValue: 0
,
  tableName: 'users'
