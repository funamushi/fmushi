Sequelize = require 'sequelize'

sequelize = module.parent.exports

module.exports = sequelize.define 'Authentication', {},
  tableName: 'authentications'
