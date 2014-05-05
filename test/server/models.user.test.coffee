require './helper'

User = require '../../src/server/models/user'

describe User, ->
  describe 'default value', ->
    beforeEach ->
      @user = User.build()

    it 'fpが0', ->
      expect(@user.fp).to.be.eql(0)

  describe 'validation', ->
    beforeEach ->
      @user = User.build(name: 'hadashiA')

    it '通る', ->
      expect(@user.validate()).to.be.null

    describe 'name', ->
      it '空にできない', ->
        @user.name = ''
        expect(@user.validate().name).to.be.present

      it 'ハイフンは使える', ->
        @user.name = 'hoge-hoge'
        expect(@user.validate()).to.be.null

      it 'アンダースコアも使える', ->
        @user.name = 'hoge_hoge'
        expect(@user.validate()).to.be.null

      it 'マルチバイト文字つかえない', ->
        @user.name = 'あ'
        expect(@user.validate().name).to.be.present

  
