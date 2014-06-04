require './helper'

Q = require 'q'

{User, Mushi, Breed, Item, Stock, Book} = require '../../src/server/models'

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

    describe '.findWithAssociations', ->
      beforeEach ->
        User.create name: 'hadashiA'
        .then (user) =>
          @user = user
          Item.create slug: 'red-circle', element: 'red'
        .then (item) =>
          Stock.create userId: @user.id, itemId: item.id
        .then (stock) ->
          Breed.create slug: 'boxing', element: 'red'
        .then (breed) =>
          Mushi.create userId: @user.id, breedId: breed.id
          Book.create userId: @user.id, breedId: breed.id

      afterEach ->
        clean(Mushi, Stock, Book).then ->
          clean(Breed, Item, User)

      it 'mushiesとstocksを読み込む', ->
        User.findWithAssociations(id: @user.id)
        .then (user) ->
          expect(user.mushies).to.have.length(1)
          expect(user.mushies[0].x).to.eq(0)
          expect(user.mushies[0].y).to.eq(0)
          expect(user.mushies[0].breed.slug).to.eq('boxing')
          expect(user.mushies[0].breed.name).to.present

          expect(user.mushies).to.have.length(1)
          expect(user.stocks[0].quantity).to.eq(1)
          expect(user.stocks[0].item.slug).to.eq('red-circle')
          expect(user.books[0].unread).to.be.true
