module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable(
      'mushies'
        id:
          type: DataTypes.INTEGER
          autoIncrement: true
          primaryKey: true
        name: DataTypes.STRING
        userId: DataTypes.INTEGER
        rankId: DataTypes.INTEGER
        circleId: DataTypes.INTEGER
        createdAt: DataTypes.DATE
        updatedAt: DataTypes.DATE
    ).complete ->
      migration.addIndex(
          'mushies'
          ['userId','rankId','circleId'],
            indexName: 'mushiIndex'
      ).complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable('mushies').complete(done)
