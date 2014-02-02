module.exports = {
  up: function(migration, DataTypes, done) {
    migration.removeColumn('items', 'itemType');

    migration.addColumn(
      'items',
      'type',
      {
        type: DataTypes.ENUM,
        values: [
          'consumption',
          'head',
          'foot',
          'leftHand',
          'rightHand',
          'arm',
          'ear',
          'body',
          'neck'
        ]
      }
    ).complete(done);
  },
  down: function(migration, DataTypes, done) {
    migration.removeColumn('items', 'type');

    migration.addColumn(
      'items',
      'ItemType',
      {
        type: DataTypes.String(128)
      }
    ).complete(done);
  }
}