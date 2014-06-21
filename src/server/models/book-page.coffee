module.exports = (sequelize,DataTypes) ->
  sequelize.define 'BookPage',
    userId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
    breedId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
  ,
    tableName: 'book_pages'

