WildMushiesDispatcher = require 'wild-mushies-dispatcher'
User    = require 'models/user'
Mushies = require 'collections/mushies'

describe 'WildMushiesDispatcher', ->
  describe '#nextTimeToAppearance', ->
    beforeEach ->
      user        = new User
      wildMushies = new Mushies
      @dispatcher = new WildMushiesDispatcher(user, wildMushies)

    describe 'ログインしてない場合', ->
      it '0秒', ->
        expect(@dispatcher.nextTimeToAppearance()).to.equal(0)

    describe 'ログインしている場合', ->
      beforeEach ->
        @dispatcher.user.loggedIn = true

      describe '虫を1匹GETしている場合', ->
        beforeEach ->
          @dispatcher.user.get('mushies').reset [
            { x: 100, y: 100 }
            ]

        it '7秒', ->
          expect(@dispatcher.nextTimeToAppearance()).to.equal(7)
        