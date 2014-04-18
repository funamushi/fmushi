module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable(
      'equipments'
        id:
          type: DataTypes.INTEGER
          autoIncrement: true
          primaryKey: true
        fmushiId: DataTypes.INTEGER
        itemId: DataTypes.INTEGER
        createdAt: DataTypes.DATE
        updatedAt: DataTypes.DATE
    ).complete ->
      migration.addIndex(
        'equipments'
        ['fmushiId','itemId'],
          indexName: 'equipmentsIndex'
      ).complete(done)
  
  down: (migration, DataTypes, done) ->
    migration.dropTable("equipments").complete(done)
