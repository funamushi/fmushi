Sequelize = require 'sequelize'

sequelize = module.parent.exports

Fmushi = sequelize.define 'Fmushi',
  tablename: 'fmushis'
  name:  Sequelize.STRING
  userId: Sequelize.INTEGER
  rankId: Sequelize.INTEGER
  circleId: Sequelize.INTEGER

