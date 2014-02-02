require './helper'

models = require '../src/server/models'
User = models.User

describe 'User Modle test', ->
  describe 'expect user', ->
    before ->
      @user = User.build({name: 'ちゃんぽん男'})

    it 'userオブジェクトがある', ->
      expect(User).to.be.ok
    
    it 'userのemailがnullである', ->
      expect(@user.email).to.not.be.ok

    it 'fpが0だよね？', ->
      console.log @user
      expect(@user.fp).to.be.eql(0)

