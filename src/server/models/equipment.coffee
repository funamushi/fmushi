Sequelize = require 'sequelize'

sequelize = module.parent.exports

module.exports = sequelize.define 'Equipment',
  {}
,
  tableName: 'equipments'
