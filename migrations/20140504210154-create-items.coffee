module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'items',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      slug:
        type: DataTypes.STRING
        allowNull: false
    .complete ->
      migration.addIndex 'items', ['slug'],
        indexName: 'items_slug'
        indicesType: 'UNIQUE'
      .complete done

  down: (migration, DataTypes, done) ->
    migration.dropTable('items').complete done
