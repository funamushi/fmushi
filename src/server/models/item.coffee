Sequelize = require 'sequelize'

sequelize = module.parent.exports

module.exports = sequelize.define 'Item',
  type:
    type: Sequelize.ENUM
    values: [
      'consumption'
      'head'
      'foot'
      'leftHand'
      'rightHand'
      'arm'
      'ear'
      'body'
      'neck'
    ]
,
  tableName: 'items'
