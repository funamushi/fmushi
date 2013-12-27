Sequelize = require 'sequelize'

sequelize = module.parent.exports

Authentication = sequelize.define 'authentication',
  provider: Sequelize.ENUM('twitter',"password","github","facebook","tumblr")
  user_id:  Sequelize.INTEGER
  uid:      Sequelize.STRING(125)
