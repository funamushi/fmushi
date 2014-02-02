Sequelize = require "sequelize"
config = require('config').db

module.exports = exports = sequelize = new Sequelize config.url, config

exports.User           = require('./user')
exports.Authentication = require('./authentication')
exports.Circle         = require('./circle')
exports.Equipment      = require('./equipment')
exports.Item           = require('./item')
exports.Mushi          = require('./mushi')
exports.Rank           = require('./rank')
