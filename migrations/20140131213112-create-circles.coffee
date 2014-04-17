module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable(
      'circles'
        id: 
          type: DataTypes.INTEGER
          autoIncrement: true
          primaryKey: true
        x: DataTypes.INTEGER
        y: DataTypes.INTEGER
        createdAt: DataTypes.DATE
        updatedAt: DataTypes.DATE
    ).complete(done)
  
  down: (migration, DataTypes, done) ->
    migration.dropTable('circles').complete(done)
