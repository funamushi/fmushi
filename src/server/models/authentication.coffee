Sequelize = require 'sequelize'

sequelize = module.parent.exports

Authentication = sequelize.define 'Authentication',
  provider: Sequelize.ENUM('twitter',"password","github","facebook","tumblr")
  user_id:  Sequelize.INTEGER
  uid:      Sequelize.STRING(125)
,
  tableName: 'authentications'
