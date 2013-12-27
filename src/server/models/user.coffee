Sequelize = require 'sequelize'

User = Sequelize.define 'Users',
  name: Sequelize.STRING
  fp:   Sequelize.INTEGER
  mail: Sequelize.STRING

module.exports = User
