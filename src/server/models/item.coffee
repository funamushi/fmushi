Sequelize = require 'sequelize'

sequelize = module.parent.exports

Item = sequelize.define 'Item',
  tablename: 'items'
  name:  Sequelize.STRING
  fp:    Sequelize.INTEGER
  effect: Sequelize.STRING
  equipmentLocation: Sequelize.ENUM('head','foot','left_hand','right_hand','arm','ear','body','neck')
