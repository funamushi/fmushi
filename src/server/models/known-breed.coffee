module.exports = (sequelize,DataTypes) ->
  sequelize.define 'KnownBreed',
    userId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
    breedId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
  ,
    tableName: 'known_breeds'

