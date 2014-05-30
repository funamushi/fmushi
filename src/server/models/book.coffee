module.export = (sequelize,DataTypes) ->
  sequelize.define 'Book',
    userId:
      type: DataTypes.INTEGER
      allowNull: false
      references: 'users'
      referencesKey: 'id'
    breedId:
      type: DataTypes.INTEGER
      allowNull: false
      references: 'breeds'
      referencesKey: 'id'
    unread:
      type: DataTypes.BOOLEAN
      defaultValue: true
      allowNull: false
  ,
    tableName: 'books'

