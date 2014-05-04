Sequelize = require 'sequelize'
db        = require '../db'

module.exports = db.define 'Item',
  slug:
    type: Sequelize.STRING
    allowNull: false
    validate:
      notNull: true
      notEmpty: true
      is: ['^[a-z-]+$']
,
  tableName: 'items'
  timestamps: false
