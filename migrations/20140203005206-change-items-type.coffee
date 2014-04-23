module.exports = 
  up: (migration, DataTypes, done) ->
    migration.removeColumn('items', 'itemType')

    migration.addColumn(
      'items'
      'type'
        type: DataTypes.ENUM
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
    ).complete(done)
  
  down: (migration, DataTypes, done) ->
    migration.removeColumn('items', 'type')

    migration.addColumn(
      'items',
      'ItemType'
        type: DataTypes.STRING(128)
    ).complete(done)
