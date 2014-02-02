Sequelize = require 'sequelize'

sequelize = module.parent.exports

module.exports = sequelize.define 'User',
  fp:
    type: Sequelize.INTEGER
    defaultValue: 0
,
  tableName: 'users'
