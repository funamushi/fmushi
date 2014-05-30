module.export = (sequelize,DataTypes) ->
  sequelize.define 'Book',
    userId:
      type: DataTypes.INTEGER
    breedId:
      type: DataTypes.INTEGER
    unread:
      type: DataTypes.BOOLEAN
      defaultValue: true
      validate:
        notNull: true,
  ,
    tableName: 'books'

