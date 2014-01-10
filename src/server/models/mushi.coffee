Sequelize = require 'sequelize'

sequelize = module.parent.exports

Mushi = sequelize.define 'Mushi',
  name:  Sequelize.STRING
  userId: Sequelize.INTEGER
  rankId: Sequelize.INTEGER
  circleId: Sequelize.INTEGER
,
  tableName: 'mushies'
