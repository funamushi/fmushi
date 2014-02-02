module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
    migration.createTable(
        'mushies',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true
          },
          name: DataTypes.STRING,
          userId: DataTypes.INTEGER,
          rankId: DataTypes.INTEGER,
          circleId: DataTypes.INTEGER,
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        }
      ).complete(function(){
        migration.addIndex(
          'mushies',
          ['userId','rankId','circleId'],
          {
            indexName: 'mushiIndex'
          }
        )
      }).complete(done)
  },
  down: function(migration, DataTypes, done) {
    // add reverting commands here, calling 'done' when finished
    migration.dropTable('mushies').complete(done)
  }
}
