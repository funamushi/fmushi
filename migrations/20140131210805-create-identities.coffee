module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'identities',
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
      userId:
        type: DataTypes.INTEGER
        allowNull: false
        references: 'users'
        referencesKey: 'id'
      provider:
        type: DataTypes.ENUM
        values: ['twitter', 'email', 'github', 'facebook', 'tumblr']
        allowNull: false
      uid:
        type: DataTypes.STRING(125)
        allowNull: false
      nickname:
        type: DataTypes.STRING(55)
      url:
        type: DataTypes.STRING(255)
      token:
        type: DataTypes.STRING(125)
      secret:
        type: DataTypes.STRING(125)
      createdAt: DataTypes.DATE
      updatedAt: DataTypes.DATE
    .then ->
      migration.addIndex 'identities', ['userId', 'provider'],
        indexName: 'identities_userId_provider'
        indicesType: 'UNIQUE'
    .then ->
      migration.addIndex 'identities', ['uid', 'provider'],
        indexName: 'identities_uid_provider'
        indicesType: 'UNIQUE'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.dropTable("authentications").complete(done)
