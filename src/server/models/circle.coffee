Sequelize = require 'sequelize'

sequelize = module.parent.exports

Circle = sequelize.define 'Circle',
  tablename: 'circles'
  x:    Sequelize.INTEGER
  y:    Sequelize.INTEGER
