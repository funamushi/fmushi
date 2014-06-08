module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn 'mushies', 'state',
      type: DataTypes.ENUM
      allowNull: false
      values: ['idle', 'walking', 'hustle', 'rest']
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.removeColumn 'mushies', 'state'
    .then ->
      done()
