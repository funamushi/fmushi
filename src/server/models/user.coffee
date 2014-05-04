Sequelize = require 'sequelize'
db        = require '../db'

Mushi = require './mushi'

module.exports = User = db.define 'User',
  name:
    type: Sequelize.STRING
    allowNull: false
    validate:
      notEmpty: true
      is: ['^[a-z_-]$', 'i']
  fp:
    type: Sequelize.INTEGER
    defaultValue: 0
    validate:
      min: 0
,
  tableName: 'users'

User.hasMany Mushi