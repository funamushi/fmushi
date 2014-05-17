module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn 'mushies', 'growth',
      type: DataTypes.FLOAT
      defaultValue: 1
    .complete done

  down: (migration, DataTypes, done) ->
    migration.removeColumn 'mushies', 'growth'
    .complete done
