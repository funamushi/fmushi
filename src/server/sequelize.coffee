Sequelize = require "sequelize"
config = require 'config'

module.exports = new Sequelize(config.db.url)
