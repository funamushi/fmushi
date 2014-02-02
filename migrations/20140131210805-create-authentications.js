module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
    migration.createTable(
      'authentications',
      {
        id: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true
        },
        userId: DataTypes.INTEGER,
        uid: DataTypes.STRING(125),
        createdAt: DataTypes.DATE,
        updatedAt: DataTypes.DATE
      }
    ).complete(function(){
       migration.addIndex(
         'authentications',
         ['userId'],
         {
           indexName: 'userIdIndex',
           indicesType: 'UNIQUE'
         }
       ).complete(done)
    })
  },
  down: function(migration, DataTypes, done) {
    // add reverting commands here, calling 'done' when finished
    migration.dropTable("authentications").complete(done)
  }
}
