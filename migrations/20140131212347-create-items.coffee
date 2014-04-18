module.exports = 
  up: (migration, DataTypes, done) ->
    migration.createTable(
      'items',
        id:
          type: DataTypes.INTEGER,
          autoIncrement: true
          primaryKey: true
        name: DataTypes.STRING
        fp: DataTypes.INTEGER
        effect: DataTypes.STRING
        itemType: DataTypes.STRING(128)
        createdAt: DataTypes.DATE
        updatedAt: DataTypes.DATE
    ).complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable("items").complete(done)
