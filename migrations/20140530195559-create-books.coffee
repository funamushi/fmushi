module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'books',
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
      unread:
        type: DataTypes.BOOLEAN
        defaultValue: true
        allowNull: false
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .then ->
      migration.addIndex 'books', ['userId'],
        indexName: 'books_userId'
    .then ->
      migration.addIndex 'books', ['breedId'],
        indexName: 'books_breedId'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable('books').complete(done)
