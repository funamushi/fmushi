module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn 'circles', 'r',
      type: DataTypes.FLOAT
      allowNull: false
    .then ->
      migration.addColumn 'circles', 'expiresAt',
        type: DataTypes.DATE
    .then ->
      migration.addColumn 'items', 'ttl',
        type: DataTypes.INTEGER
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.removeColumn 'circles', 'r'
    .then ->
      migration.removeColumn 'circles', 'expiresAt'
    .then ->
      migration.removeColumn 'items', 'ttl'
    .then ->
      done()
