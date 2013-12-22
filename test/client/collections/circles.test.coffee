describe Fmushi.Collections.Circles, ->
  beforeEach ->
    @user = new Fmushi.Models.User
      name: 'hadashiA'

  describe '#initialize', ->
    it 'userオプションをプロパティにセット', ->
      mushies = new Fmushi.Collections.Circles [], user: @user
      expect(mushies.user).to.equal(@user)

  describe '#url', ->
    it '/:userName/circles', ->
      mushies = new Fmushi.Collections.Circles [], user: @user
      expect(mushies.url()).to.equal('/hadashiA/circles')
      