module.exports = {
  up: function(migration, DataTypes, done) {
    migration.createTable(
      'equipments',
      {
        id: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true
        },
        fmushiId: DataTypes.INTEGER,
        itemId: DataTypes.INTEGER,
        createdAt: DataTypes.DATE,
        updatedAt: DataTypes.DATE
      }
    ).complete(function(){
      migration.addIndex(
        'equipments',
        ['fmushiId','itemId'],
        {
          indexName: 'equipmentsIndex'
        }
        ).complete(done)
    })
    // add altering commands here, calling 'done' when finished
  },
  down: function(migration, DataTypes, done) {
    // add reverting commands here, calling 'done' when finished
    migration.dropTable("equipments").complete(done)
  }
}
