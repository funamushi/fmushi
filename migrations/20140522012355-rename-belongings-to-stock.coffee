module.exports = 
  up: (migration, DataTypes, done) ->
    migration.renameTable 'belongings','stocks'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.renameTable 'stocks', 'belongings'
    .then ->
      done()
