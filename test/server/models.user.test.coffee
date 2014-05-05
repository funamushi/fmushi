require './helper'

Q = require 'q'

{User, Mushi, Breed, Item, Belonging} = require '../../src/server/models'

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

    describe 'JSON', ->
      beforeEach ->
        User.create name: 'hadashiA'
        .then (user) =>
          @user = user
          Item.create slug: 'red-circle'
        .then (item) =>
          Belonging.create userId: @user.id, itemId: item.id
        .then (belonging) ->
          Breed.create slug: 'boxing'
        .then (breed) =>
          Mushi.create userId: @user.id, breedId: breed.id

      afterEach ->
        Q.all [Mushi.destroy(), Belonging.destroy()]
        .then ->
          Q.all [Breed.destroy(), Item.destroy(), User.destroy()]

      it 'mushiesとbelongingsを内包するJSONを返す', ->
        User.find
          where: { id: @user.id }
          include: [Mushi, Belonging]
        .then (user) ->
          console.log JSON.stringify(user)
