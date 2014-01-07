Sequelize = require 'sequelize'

sequelize = module.parent.exports

Rank = sequelize.define 'Rank',
  tablename: 'ranks'
  grade: Sequelize.INTEGER
  name:  Sequelize.STRING
