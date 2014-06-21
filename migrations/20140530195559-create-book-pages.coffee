module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'book_pages',
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
      migration.addIndex 'book_pages', ['userId'],
        indexName: 'book_pages_userId'
    .then ->
      migration.addIndex 'book_pages', ['breedId'],
        indexName: 'book_pages_breedId'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('book_pages').complete(done)
