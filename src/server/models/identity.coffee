Sequelize = require 'sequelize'
db        = require '../db'

module.exports = db.define 'Identity',
  userId:
    type: Sequelize.INTEGER
    allowNull: false
    references: 'users'
    referencesKey: 'id'
    validate:
      notNull: true
  provider:
    type: Sequelize.ENUM
    values: ['twitter', 'email', 'github', 'facebook', 'tumblr']
    allowNull: false
    validate:
      notNull: true
  uid:
    type: Sequelize.STRING(125)
    allowNull: false
    validate:
      notNull: true
  nickname:
    type: Sequelize.STRING(55)
  url:
    type: Sequelie.STRING(255)
  token:
    type: Sequelize.STRING(125)
  secret:
    type: Sequelize.STRING(125)
,
  tableName: 'identities'
