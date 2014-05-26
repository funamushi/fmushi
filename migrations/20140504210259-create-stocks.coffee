module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'stocks',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      userId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'users'
        referencesKey: 'id'
      itemId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'items'
        referencesKey: 'id'
      quantity:
        type: DataTypes.INTEGER
        defaultValue: 0
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .then ->
      migration.addIndex 'stocks', ['userId', 'itemId'],
        indexName: 'stocks_userId'
        indicesType: 'UNIQUE'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('stocks').complete(done)
