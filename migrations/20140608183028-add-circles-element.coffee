module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn 'circles', 'element',
      type: DataTypes.ENUM
      allowNull: false
      values: ['red', 'blue']
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.removeColumn 'circles', 'element'
    .then ->
      done()
