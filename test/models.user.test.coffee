require './helper'

User = require '../src/server/models/user'

describe 'User Modle test', ->
  describe 'expect user', ->
    before ->
      @user = User.build(name: 'ちゃんぽん男')

    it 'fpが0だよね？', ->
      expect(@user.fp).to.be.eql(0)

