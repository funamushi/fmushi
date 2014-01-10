Sequelize = require 'sequelize'

sequelize = module.parent.exports

Rank = sequelize.define 'Rank',
  grade: Sequelize.INTEGER
  name:  Sequelize.STRING
,
  tableName: 'ranks'
