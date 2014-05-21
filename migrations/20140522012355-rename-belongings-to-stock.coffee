module.exports = 
  up: (migration, DataTypes, done) ->
    migration.renameTable 'belongings','stock'
    .then ->
      done()

  down: (migration, DataTypes, done) ->
    migration.renameTable 'stock', 'belongings'
    .then ->
      done()
