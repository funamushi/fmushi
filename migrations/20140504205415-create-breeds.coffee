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
      element:
        type: DataTypes.ENUM
        values: ['red', 'blue']
        allowNull: false
    .then ->
      migration.addIndex 'breeds', ['slug'],
        indexName: 'breeds_slug'
        indicesType: 'UNIQUE'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('breeds').complete done
