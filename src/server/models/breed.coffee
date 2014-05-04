Sequelize = require 'sequelize'
db        = require '../db'

module.exports = sequelize.define 'Breed',
  slug:
    type: Sequelize.STRING
    allowNull: false
    validate:
      notNull: true
      notEmpty: true
      is: ['^[a-z-]+$']
,
  tableName: 'breeds'
  