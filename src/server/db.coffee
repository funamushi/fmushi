path = require 'path'

Sequelize = require "sequelize"

config = require(path.resolve './config/config.json')
config = config[process.env.NODE_ENV or 'development']

module.exports = new Sequelize(
  config.database, config.username, config.password, config
)
