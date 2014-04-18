module.exports =
  up: (migration, DataTypes) ->
    migration.removeIndex('authentications', 'userIdIndex')
    migration.addIndex(
      'authentications'
      ['userId', 'provider'],
        indexName: 'authentications_userId_provider'
        indicesType: 'UNIQUE'
    )

    migration.removeIndex('equipments', 'equipmentsIndex')
    migration.renameColumn('equipments', 'fmushiId', 'mushiId').complete ->
      migration.addIndex(
        'equipments'
          ['mushiId', 'itemId'],
          indexName: 'equipments_mushiId_itemId'
          indicesType: 'UNIQUE'
      )

    migration.removeIndex('mushies', 'mushiIndex')
    migration.addIndex('mushies', ['userId'], { indexName: 'mushies_userId' })
    migration.addIndex('mushies', ['rankId'], { indexName: 'mushies_rankId' })
    migration.addIndex('mushies', ['circleId'], { indexName: 'mushies_circleId' })

  down: (migration, DataTypes) ->
    migration.removeIndex('authentications', 'authentications_userId_provider')
    migration.addIndex(
      'authentications'
        ['userId'],
        indexName: 'userIdIndex'
        indicesType: 'UNIQUE'
    )

    migration.removeIndex 'equipments', 'equipments_mushiId_itemId'
    migration.renameColumn('equipments', 'mushiId', 'fmushiId').complete -> 
      migration.addIndex(
        'equipments'
        ['fmushiId','itemId'],
          indexName: 'equipmentsIndex'
      )

    migration.removeIndex 'mushies', 'userId'
    migration.removeIndex 'mushies', 'rankId'
    migration.removeIndex 'mushies', 'circleId'
    migration.addIndex(
      'mushies'
      ['userId','rankId','circleId'],
        indexName: 'mushiIndex'
    )
