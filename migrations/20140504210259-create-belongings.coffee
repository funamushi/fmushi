module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'belongings',
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
      migration.addIndex 'belongings', ['userId'],
        indexName: 'belongings_userId'
      .complete done

  down: (migration, DataTypes, done) ->
    migration.dropTable('belongings').complete(done)
