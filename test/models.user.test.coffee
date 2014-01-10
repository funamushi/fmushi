models = require '../src/server/models'
User = models.User

chai = require 'chai'
expect = chai.expect

describe 'User Modle test', ->
  describe 'expect user', ->
    before ->
      @user = User.build({name: 'ちゃんぽん男'})

    it 'userオブジェクトがある', ->
      expect(User).to.be.ok
    
    it 'userのemailがnullである', ->
      expect(@user.email).to.be.null

    it 'fpが0だよね？', ->
      expect(@user.fp).to.be.eql(0)

