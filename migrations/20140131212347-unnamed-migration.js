module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
    migration.createTable(
      'items',
      {
        id: {
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primartyKey: true
        },
        name: DataTypes.STRING,
        fp: DataTypes.INTEGER,
        effect: DataTypes.STRING,
        itemType: {
          type: DataTypes.ENUM,
          values: ['consumption','head','foot','leftHand','rightHand','arm','ear','body','neck']
        },
        createdAt: DataTypes.DATE,
        updatedAt: DataTypes.DATE
      }
    ).complete(done)
  },
  down: function(migration, DataTypes, done) {
    // add reverting commands here, calling 'done' when finished
    migration.dropTable("items").complete(done)
  }
}
