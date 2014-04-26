Sequelize = require 'sequelize'
sequelize = require '../sequelize'

module.exports = User = sequelize.define 'User',
  name:
    type: Sequelize.STRING
    validate:
      notEmpty: true
  fp:
    type: Sequelize.INTEGER
    defaultValue: 0
,
  tableName: 'users'
