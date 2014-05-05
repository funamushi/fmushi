module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Identity',
    userId:
      type: DataTypes.INTEGER
      allowNull: false
      references: 'users'
      referencesKey: 'id'
      validate:
        notNull: true
    provider:
      type: DataTypes.ENUM
      values: ['twitter', 'email', 'github', 'facebook', 'tumblr']
      allowNull: false
      validate:
        notNull: true
    uid:
      type: DataTypes.STRING(125)
      allowNull: false
      validate:
        notNull: true
    nickname:
      type: DataTypes.STRING(55)
    url:
      type: DataTypes.STRING(255)
    token:
      type: DataTypes.STRING(125)
    secret:
      type: DataTypes.STRING(125)
  ,
    tableName: 'identities'


