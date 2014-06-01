module.exports = (sequelize, DataTypes) ->
  sequelize.define 'Identity',
    userId:
      type: DataTypes.INTEGER
      validate:
        notNull: true
    provider:
      type: DataTypes.ENUM
      values: ['twitter', 'email', 'github', 'facebook', 'tumblr']
      validate:
        notNull: true
    uid:
      type: DataTypes.STRING(125)
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
    classMethods:
      buildFromProfile: (profile) ->
        @build
          provider: profile.provider
          uid:      profile.id
          nickname: profile.username
          token:    profile.token
          secret:   profile.secret
        

