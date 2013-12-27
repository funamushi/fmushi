Sequelize = require "sequelize"
config = require('config').db

module.exports = exports = sequelize = new Sequelize config.url, config

exports.User = require('./user')

