Sequelize = require './models'
User = new sequelize.User
Sequelize.User.sync()

describe 'User Modle test', ->
  describe 'データベース操作', ->
    it '保存できる', (done) ->
      newUser = new User
        name: "うしわかまる"
        fp: 1000
        email: "ushiwaka@com.com"
      newUser.save((err) ->
        if err? throw err
          done()
      )
