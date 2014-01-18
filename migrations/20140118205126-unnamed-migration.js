module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
      migration.createTabel(
          "users",
          {
            id: {
              type: DataTypes.INTEGER,
              autoIncrement: true,
              primartyKey: true
            },
            name: {
              type: DataTypes.STRING
            },
            fp: {
              type: DataTypes.INTEGER,
              defaultValue: 0
            },
            email: {
              type: DataTypes.STRING,
              allowNUll: true
            }
          },
          "authentications",
          {
            id: {
              type: DataTypes.INTEGER,
              autoIncrement: true,
              primartyKey: true
            },
            userId: {
              type: DataTypes.INTEGER
            },
            uid: {
              type: DataTypes.STRING
            }
          }
      )
    migration.addIndex(
        "authentications",
        ['userId'],
        {
          indexName: 'userIdIndex',  // default = _ らしい
          indicesType: 'UNIQUE'
        }
    )
    done()
  },
  down: function(migration, DataTypes, done) {
    // add reverting commands here, calling 'done' when finished
    done()
  }
}
