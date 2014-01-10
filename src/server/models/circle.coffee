Sequelize = require 'sequelize'

sequelize = module.parent.exports

Circle = sequelize.define 'Circle', {
  x:    Sequelize.INTEGER
  y:    Sequelize.INTEGER
}, {
  tableName: 'circles'
}
