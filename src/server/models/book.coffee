module.export = (sequelize,DataTypes) ->
  sequelize.define 'Book',
    userId:
      type: DataTypes.INTEGER
      referencesKey: 'id'
    breedId:
      type: DataTypes.INTEGER
      referencesKey: 'id'
    unread:
      type: DataTypes.BOOLEAN
  ,
    tableName: 'books'

