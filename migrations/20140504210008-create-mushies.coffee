module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'mushies',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      userId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'users'
        referencesKey: 'id'
      breedId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'breeds'
        referencesKey: 'id'
      x:
        type: DataTypes.FLOAT
        defaultValue: 0
      y:
        type: DataTypes.FLOAT
        defaultValue: 0
      direction:
        type: DataTypes.ENUM
        values: ['left', 'right']
        allowNull: false
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .then ->
      migration.addIndex 'mushies', ['userId'],
        indexName: 'mushies_userId'
    .then ->
      migration.addIndex 'mushies', ['breedId'],
        indexName: 'mushies_breedId'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('mushies').complete(done)
