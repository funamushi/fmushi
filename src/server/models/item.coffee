Sequelize = require 'sequelize'

sequelize = module.parent.exports

Item = sequelize.define 'Item',
  tablename: 'items'
  name:  Sequelize.STRING
  fp:    Sequelize.INTEGER
  effect: Sequelize.STRING
  type: Sequelize.ENUM('consumption','head','foot','leftHand','rightHand','arm','ear','body','neck')
