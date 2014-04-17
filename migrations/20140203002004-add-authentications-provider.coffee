module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn(
      'authentications'
      'provider'
        type: DataTypes.ENUM
        values: ['twitter', 'password', 'github', 'facebook', 'tumblr']
    ).complete(done)
  
  down: (migration, DataTypes, done) ->
    migration.removeColumn(
      'authentications'
      'provider'
    ).complete(done)
