module.exports = {
  up: function(migration, DataTypes, done) {
    migration.addColumn(
      'authentications',
      'provider',
      {
        type: DataTypes.ENUM,
        values: ['twitter', 'password', 'github', 'facebook', 'tumblr']
      }
    ).complete(done);
  },
  down: function(migration, DataTypes, done) {
    migration.removeColumn(
      'authentications',
      'provider'
    ).complete(done);
  }
}