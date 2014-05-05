module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Breed',
    slug:
      type: DataTypes.STRING
      allowNull: false
      validate:
        notNull: true
        notEmpty: true
        is: ['^[a-z-]+$']
  ,
    tableName: 'breeds'
    timestamps: false
  