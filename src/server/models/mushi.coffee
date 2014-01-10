Sequelize = require 'sequelize'

sequelize = module.parent.exports

Mushi = sequelize.define 'Mushi',
  tablename: 'mushies'
  name:  Sequelize.STRING
  userId: Sequelize.INTEGER
  rankId: Sequelize.INTEGER
  circleId: Sequelize.INTEGER

