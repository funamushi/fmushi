sequelize = require '../db'

module.exports = sequelize.define 'Item',
  slug:
    type: Sequelize.STRING
    allowNull: false
    validate:
      notNull: true
      notEmpty: true
      is: ['^[a-z-]+$']
,
  tableName: 'items'
