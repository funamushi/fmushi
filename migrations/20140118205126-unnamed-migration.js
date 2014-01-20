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
            },
            createdAt: {
              type: DataTypes.DATE
            }
            updatedAt: {
              type: DataTypes.DATE
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
            },
            createdAt: {
              type: DataTypes.DATE
            }
            updatedAt: {
              type: DataTypes.DATE
            }

          },
          "equipments",
          {
            id: {
              type: DataTypes.INTEGER,
              autoIncrement: true,
              primartyKey: true
            },
            fmushiId: {
              type: DataTypes.INTEGER
            },
            itemId: {
              type: DataTypes.INTEGER
            },
            createdAt: {
              type: DataTypes.DATE
            }
            updatedAt: {
              type: DataTypes.DATE
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
    ),
    done()
  },
  down: function(migration, DataTypes, done) {
    migration.dropAllTables()
    // add reverting commands here, calling 'done' when finished
    done()
  }
}
