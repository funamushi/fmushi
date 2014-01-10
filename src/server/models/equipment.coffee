Sequelize = require 'sequelize'

sequelize = module.parent.exports

Equipment= sequelize.define 'Equipment',
  fmushiId: Sequelize.INTEGER
  itemId: Sequelize.INTEGER
,
  tableName: 'equipments'
