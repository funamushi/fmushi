module.exports = {
  up: function(migration, DataTypes, done) {
    // add altering commands here, calling 'done' when finished
      migration.createTabel(
        'users',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primartyKey: true
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
        },
        'authentications',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primartyKey: true
          },
          userId: DataTypes.INTEGER,
          uid: DataTypes.STRING(125),
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        },
        'equipments',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primartyKey: true
          },
          fmushiId: DataTypes.INTEGER,
          itemId: DataTypes.INTEGER,
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        },
        'items',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primartyKey: true
          },
          name: type: DataTypes.STRING,
          fp: DataTypes.INTEGER,
          effect: DataTypes.STRING,
          type: DataTypes.ENUM('consumption','head','foot','leftHand','rightHand','arm','ear','body','neck')
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        },
        'ranks',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primartyKey: true
          },
          grade: DataTypes.INTEGER,
          name: DataTypes.STRING,
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        },
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
        },
        'mushies',
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primartyKey: true
          },
          name: DataTypes.STRING,
          userId: DataTypes.INTEGER,
          rankId: DataTypes.INTEGER,
          circleId: DataTypes.INTEGER,
          createdAt: DataTypes.DATE,
          updatedAt: DataTypes.DATE
        }
      )
    migration.addIndex(
        'authentications',
        ['userId'],
        {
          indexName: 'userIdIndex',  // default = _ らしい
          indicesType: 'UNIQUE'
        },
        'equipments',
        ['fmushiId','itemId'],
        {
          indexName: 'equipmentsIndex',
        },
        'mushies',
        ['userId','rankId','circleId'],
        {
          indexName: 'mushiIndex'
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
