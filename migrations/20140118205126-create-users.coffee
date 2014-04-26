module.exports =
  up: (migration, DataTypes, done)  ->
    migration.createTable 'users',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      name:
        type: DataTypes.STRING
        allowNull: false
      fp:
        type: DataTypes.INTEGER
        defaultValue: 0
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .complete ->
      migration.addIndex 'users', ['name'],
        indexName:   'users_name'
        indicesType: 'UNIQUE'
      .complete done
  
  down: (migration, DataTypes, done) ->
    migration.dropTable("users").complete(done)
