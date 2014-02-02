module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
      migration.createTable(
        'users',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
          name: DataTypes.STRING,
          fp: {
            type: DataTypes.INTEGER,
            defaultValue: 0
          },
          email: {
            type: DataTypes.STRING,
            allowNUll: true
          },
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        }
      ).complete(done)
  },
  down: function(migration, DataTypes, done) {
    migration.dropTable("users").complete(done)
    // add reverting commands here, calling 'done' when finished
  }
}
