module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'breeds',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      slug:
        type: DataTypes.STRING
        allowNull: false
    .complete ->
      migration.addIndex 'breeds', ['slug'],
        indexName: 'breeds_slug'
        indicesType: 'UNIQUE'
      .complete done

  down: (migration, DataTypes, done) ->
    migration.dropTable('breeds').complete done
