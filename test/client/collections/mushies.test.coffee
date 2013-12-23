describe Fmushi.Collections.Mushies, ->
  beforeEach ->
    @user = new Fmushi.Models.User
      name: 'hadashiA'

  describe '#initialize', ->
    it 'userオプションをプロパティにセット', ->
      mushies = new Fmushi.Collections.Mushies [], user: @user
      expect(mushies.user).to.equal(@user)

  describe '#url', ->
    it '/:userName/mushies', ->
      mushies = new Fmushi.Collections.Mushies [], user: @user
      expect(mushies.url()).to.equal('/hadashiA/mushies')
      