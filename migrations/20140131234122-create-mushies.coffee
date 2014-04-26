module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'mushies',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      userId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'users'
        referencesKey: 'id'
      circleId: DataTypes.INTEGER
      name:
        type: DataTypes.STRING
        allowNull: false
      x:
        type: DataTypes.FLOAT
        defaultValue: 0
      y:
        type: DataTypes.FLOAT
        defaultValue: 0
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .complete ->
      migration.addIndex 'mushies', ['userId'],
        indexName: 'mushies_userId'
      .complete ->
        migration.addIndex 'mushies', ['circleId'],
          indexName: 'mushies_circleId'
        .complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable('mushies').complete(done)
