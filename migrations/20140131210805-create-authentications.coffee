module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable(
      'authentications'
        id:
          type: DataTypes.INTEGER
          autoIncrement: true
          primaryKey: true
        userId: DataTypes.INTEGER
        uid: DataTypes.STRING(125)
        createdAt: DataTypes.DATE
        updatedAt: DataTypes.DATE
    ).complete ->
       migration.addIndex(
         'authentications'
         ['userId'],
           indexName: 'userIdIndex'
           indicesType: 'UNIQUE'
       ).complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable("authentications").complete(done)
