path      = require 'path'
Sequelize = require "sequelize"

config = require 'config'

module.exports = exports = new Sequelize(config.db.url)

exports.User           = require './user'
exports.Authentication = require './authentication'
exports.Circle         = require './circle'
exports.Equipment      = require './equipment'
exports.Item           = require './item'
exports.Mushi          = require './mushi'
exports.Rank           = require './rank'


