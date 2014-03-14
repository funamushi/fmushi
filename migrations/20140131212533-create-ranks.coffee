module.exports = 
  up: (migration, DataTypes, done) ->
    migration.createTable(
      'ranks',
        id: 
          type: DataTypes.INTEGER
          autoIncrement: true
          primaryKey: true
        grade: DataTypes.INTEGER
        name: DataTypes.STRING
        createdAt: DataTypes.DATE
        updatedAt: DataTypes.DATE
    ).complete(done)
  
  down: (migration, DataTypes, done) ->
    migration.dropTable("ranks").complete(done)
