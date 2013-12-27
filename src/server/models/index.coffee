Sequelize = require "sequelize"
config = require "config"

sequelize = new Sequelize config.db.database,config.db.username,config.db.password,config.db

User = sequelize.define 'Users',
    name: Sequelize.STRING
    fp: Sequelize.INTEGER
    mail: Sequelize.STRING


module.exports = exports = sequelize

# exports.user = require './user'

