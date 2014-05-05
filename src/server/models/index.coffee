path = require 'path'

Sequelize = require "sequelize"

config = require(path.resolve './config/config.json')
config = config[process.env.NODE_ENV or 'development']

module.exports = sequelize = new Sequelize(
  config.database, config.username, config.password, config
)

sequelize.User      = User      = sequelize.import('./user')
sequelize.Identity  = Identity  = sequelize.import('./identity')
sequelize.Item      = Item      = sequelize.import('./item')
sequelize.Belonging = Belonging = sequelize.import('./belonging')
sequelize.Breed     = Breed     = sequelize.import('./breed')
sequelize.Mushi     = Mushi     = sequelize.import('./mushi')

User
.hasMany Identity
.hasMany Mushi, as: 'Mushies'
.hasMany Belonging

Mushi
.belongsTo User
.belongsTo Breed

Belonging
.belongsTo User
.belongsTo Item
