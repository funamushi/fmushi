Sequelize = require 'sequelize'

sequelize = module.parent.exports

module.exports = sequelize.define 'Mushi', {},
  tableName: 'mushies'
