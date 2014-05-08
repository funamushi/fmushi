path = require 'path'

Sequelize = require "sequelize"

config = require(path.resolve './config/config.json')
config = config[process.env.NODE_ENV or 'development']

exports.sequelize = sequelize = new Sequelize(
  config.database, config.username, config.password, config
)

exports.User      = User      = sequelize.import('./user')
exports.Identity  = Identity  = sequelize.import('./identity')
exports.Item      = Item      = sequelize.import('./item')
exports.Belonging = Belonging = sequelize.import('./belonging')
exports.Breed     = Breed     = sequelize.import('./breed')
exports.Mushi     = Mushi     = sequelize.import('./mushi')

User
.hasMany Identity
.hasMany Mushi
.hasMany Belonging

Identity
.belongsTo User

Mushi
.belongsTo User
.belongsTo Breed

Belonging
.belongsTo User
.belongsTo Item
