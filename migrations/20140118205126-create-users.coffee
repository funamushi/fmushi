module.exports =
  up: (migration, DataTypes, done)  ->
      migration.createTable(
        'users'
          id:
            type: DataTypes.INTEGEr
            autoIncrement: true
            primaryKey: true
          name: DataTypes.STRING
          fp:
            type: DataTypes.INTEGER
            defaultValue: 0
          email:
            type: DataTypes.STRING
            allowNUll: true
          createdAt: DataTypes.DATE
          updatedAt: DataTypes.DATE
      ).complete(done)
  ,
  down: (migration, DataTypes, done) ->
    migration.dropTable("users").complete(done)
