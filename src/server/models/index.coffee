Sequelize = require "sequelize"
config = require "config"

module.exports = exports = sequelize = new Sequelize config.db.database,config.db.username,config.db.password,config.db

exports.User = require('./user')
exports.Authentication = require('./authentication')
