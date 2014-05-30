module.export = (sequelize,DataTypes) ->
  sequelize.define 'Book',
    userId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
    breedId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
    unread:
      type: DataTypes.BOOLEAN
      defaultValue: true
      validate:
        notNull: true
  ,
    tableName: 'books'

