module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'known_breeds',
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
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .then ->
      migration.addIndex 'known_breeds', ['userId'],
        indexName: 'known_breeds_userId'
    .then ->
      migration.addIndex 'known_breeds', ['breedId'],
        indexName: 'known_breeds_breedId'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('known_breeds').complete(done)
