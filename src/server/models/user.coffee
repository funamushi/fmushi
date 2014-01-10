Sequelize = require 'sequelize'

sequelize = module.parent.exports

User = sequelize.define 'User',
  name:  Sequelize.STRING
  fp:    Sequelize.INTEGER
  email: Sequelize.STRING
,
  tableName: 'users'
