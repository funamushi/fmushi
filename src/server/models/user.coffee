Sequelize = require 'sequelize'

sequelize = module.parent.exports

User = sequelize.define 'User',
  name:  Sequelize.STRING
  test:  Sequelize.STRING
  fp:
    type:Sequelize.INTEGER
    defaultValue: 0
  email:
    type:Sequelize.STRING
    allowNull: true
    defaultValue: null
,
  tableName: 'users'

module.exports = User
