Sequelize = require 'Sequelize'
db        = require '../db'

module.exports = Mushi = db.define 'Mushi',
  x:
    type: Sequelize.FLOAT
    defaultValue: 0
  y:
    type: Sequelize.FLOAT
    defaultValue: 0
  direction:
    type: Sequelize.ENUM
    values: ['left', 'right']
    allowNull: false
,
  tableName: 'mushies'
