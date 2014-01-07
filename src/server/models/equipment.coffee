Sequelize = require 'sequelize'

sequelize = module.parent.exports

Equipment= sequelize.define 'Equipment',
  tablename: 'equipments'
  fmushiId: Sequelize.INTEGER
  itemId: Sequelize.INTEGER
