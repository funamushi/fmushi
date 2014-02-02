module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
    migration.createTable(
      'circles',
      {
        id: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primartyKey: true
        },
        x: DataTypes.INTEGER,
        y: DataTypes.INTEGER,
        createdAt: DataTypes.DATE,
        updatedAt: DataTypes.DATE
      }
    ).complete(done)
  },
  down: function(migration, DataTypes, done) {
    // add reverting commands here, calling 'done' when finished
    migration.dropTable('circles').complete(done)
  }
}
