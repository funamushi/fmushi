Sequelize = require 'sequelize'

sequelize = module.parent.exports

module.exports = sequelize.define 'Authentication',
  provider:
    type:   Sequelize.ENUM
    values: ['twitter', 'password', 'github', 'facebook', 'tumblr']
,
  tableName: 'authentications'
