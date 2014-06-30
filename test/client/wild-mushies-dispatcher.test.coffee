WildMushiesDispatcher = require 'views/wild-mushies-dispatcher'
User    = require 'models/user'
Mushies = require 'collections/mushies'

describe 'WildMushiesDispatcher', ->
  describe '#nextIntervalToAppearance', ->
    beforeEach ->
      user        = new User
      wildMushies = new Mushies
      @dispatcher = new WildMushiesDispatcher
        owner: user
        collection: wildMushies

    describe 'ログインしてない場合', ->
      it '0秒', ->
        expect(@dispatcher.nextIntervalToAppearance()).to.equal(0)

    describe 'ログインしている場合', ->
      beforeEach ->
        @dispatcher.owner.set 'id', 1

      describe '虫を1匹GETしている場合', ->
        beforeEach ->
          @dispatcher.owner.get('mushies').reset [
            { x: 100, y: 100 }
            ]

        it '7秒', ->
          expect(@dispatcher.nextIntervalToAppearance()).to.equal(7)
        