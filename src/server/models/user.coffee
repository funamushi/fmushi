Sequelize = require 'sequelize'

sequelize = module.parent.exports

User = sequelize.define 'users',
  name:  Sequelize.STRING
  fp:    Sequelize.INTEGER
  email: Sequelize.STRING
