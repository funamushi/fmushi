path = require 'path'
Sequelize = require "sequelize"

configs = require path.resolve('./config/config.json')
config = configs[process.env.NODE_ENV or 'development']

module.exports = exports = sequelize =
  new Sequelize(config.database, config.username, config.password, config)

exports.User           = require('./user')
exports.Authentication = require('./authentication')
exports.Circle         = require('./circle')
exports.Equipment      = require('./equipment')
exports.Item           = require('./item')
exports.Mushi          = require('./mushi')
exports.Rank           = require('./rank')
