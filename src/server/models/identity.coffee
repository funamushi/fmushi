Sequelize = require 'sequelize'
sequelize = require '../sequelize'

module.exports = sequelize.define 'Identity',
  userId:
    type: Sequelize.INTEGER
    allowNull: false
    references: 'users'
    referencesKey: 'id'
  provider:
    type: Sequelize.ENUM
    values: ['twitter', 'email', 'github', 'facebook', 'tumblr']
    allowNull: false
  uid:
    type: Sequelize.STRING(125)
    allowNull: false
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








