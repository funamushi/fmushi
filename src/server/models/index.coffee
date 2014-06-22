path = require 'path'
_    = require 'lodash'
Q    = require 'q'

Sequelize = require "sequelize"

dbConfig = require(path.resolve './config/config.json')
dbConfig = dbConfig[process.env.NODE_ENV or 'development']

config = require 'config'

module.exports = sequelize = new Sequelize(
  dbConfig.database, dbConfig.username, dbConfig.password, dbConfig
)

sequelize.Item       = Item       = sequelize.import('./item')
sequelize.Breed      = Breed      = sequelize.import('./breed')
sequelize.Stock      = Stock      = sequelize.import('./stock')
sequelize.Mushi      = Mushi      = sequelize.import('./mushi')
sequelize.Identity   = Identity   = sequelize.import('./identity')
sequelize.KnownBreed = KnownBreed = sequelize.import('./known-breed')
sequelize.User       = User       = sequelize.import('./user')

User
.hasMany Identity
.hasMany Mushi
.hasMany Stock
.hasMany KnownBreed

Identity
.belongsTo User

Mushi
.belongsTo User
.belongsTo Breed

Stock
.belongsTo User
.belongsTo Item

KnownBreed
.belongsTo User
.belongsTo Breed

User.findWithAssociations = (where) ->
  options =
    include: [
      model: Identity, attributes: ['provider', 'nickname', 'url']
    ,
      model: Mushi, include: [
        model: Breed
      ]
    ,
      model: Stock, include: [
        model: Item
      ]
    ]
  options.where = where
  @find options
