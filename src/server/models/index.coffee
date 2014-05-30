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
sequelize.Stock     = Stock     = sequelize.import('./stock')
sequelize.Breed     = Breed     = sequelize.import('./breed')
sequelize.Mushi     = Mushi     = sequelize.import('./mushi')
sequelize.Book      = Book      = sequelize.import('./book')

User
.hasMany Identity
.hasMany Mushi
.hasMany Stock
.hasMany Book

Identity
.belongsTo User

Mushi
.belongsTo User
.belongsTo Breed

Stock
.belongsTo User
.belongsTo Item

Book
.belongsTo User
.belongsTo Breed

User.findWithAssociations = (where) ->
  options =
    include: [
      model: Identity, attributes: ['provider', 'nickname', 'url']
    ,
      model: Mushi, attributes: ['x', 'y', 'direction'], include: [
        model: Breed, attributes: ['slug']
      ]
    ,
      model: Stock, attributes: ['quantity'], include: [
        model: Item, attributes: ['slug']
      ]
    ,
      model: Book, attributes: ['unread'], include: [
        model: Breed, attributes: ['slug']
      ]
    ]
  options.where = where
  @find options
  
