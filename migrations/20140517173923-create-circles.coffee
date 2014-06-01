module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'circles',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      itemId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'items'
        referencesKey: 'id'
      x:
        type: DataTypes.FLOAT
        defaultValue: 0
      y:
        type: DataTypes.FLOAT
        defaultValue: 0
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE

    .then ->
      migration.addIndex 'circles', ['itemId'],
        indexName: 'circles_itemId'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('circles').complete done
