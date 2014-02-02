module.exports = {
  up: function(migration, DataTypes) {
    migration.addColumn(
      'authentications',
      'provider',
      {
        type: DataTypes.ENUM,
        values: ['twitter', 'password', 'github', 'facebook', 'tumblr']
      }
    );
  },
  down: function(migration, DataTypes) {
    migration.removeColumn(
      'authentications',
      'provider'
    );
  }
}