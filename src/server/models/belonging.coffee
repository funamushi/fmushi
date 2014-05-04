Sequelize = require 'Sequelize'
db        = require '../db'

module.exports = db.define 'Belonging',
  quantity:
    type: Sequelize.INTEGER
    defaultValue: 0
    validate:
      isInt: true
      min: 0
      max: 99
,
  tableName: 'belongings'
