Sequelize = require 'sequelize'

sequelize = module.parent.exports

Item = sequelize.define 'Item',
  tablename: 'items'
  name:  Sequelize.STRING
  fp:    Sequelize.INTEGER
  effect: Sequelize.STRING
  classification: Sequelize.ENUM('equipment','consumption')
  equipmentLocation: Sequelize.ENUM('head','foot','leftHand','rightHand','arm','ear','body','neck'),allowNull: true,defaultValue: NULL
