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
        clean(Mushi, Belonging).then ->
          clean(Breed, Item, User)

      it 'mushiesとbelongingsを内包するJSONを返す', ->
        User.find
          where: { id: @user.id }
          attributes: ['name', 'fp']
          include: [
            { model: Mushi, attributes: ['x', 'y', 'direction'], include: [
                model: Breed, attributes: ['slug']
              ] }
          ]
        .then (user) ->
          json = JSON.parse(JSON.stringify(user))
          expect(json.name).to.eq('hadashiA')
          expect(json.mushies[0].x).to.eq(0)
          expect(json.mushies[0].y).to.eq(0)
          expect(json.mushies[0].breed.slug).to.eq('boxing')
          expect(json.mushies[0].breed.name).to.present
