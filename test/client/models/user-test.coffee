describe Fmushi.Models.Mushi, ->
  describe '#isValid', ->
    beforeEach ->
      @user = new Fmushi.Models.User name: 'hoge', fp: 100

    it 'nameは空にできない', ->
      @user.set 'name', ''
      expect(@user.isValid()).to.not.be.ok
      expect(@user.validationError[0].attr).to.equal('name')

    it 'fpは0未満にできない', ->
      @user.set 'fp', -1
      expect(@user.isValid()).to.not.be.ok
      expect(@user.validationError[0].attr).to.equal('fp')

  describe '#addFp', ->
    beforeEach ->
      @user = new Fmushi.Models.User

    it 'デフォルトのfpは0', ->
      expect(@user.get('fp')).to.equal 0
      

    it 'fpを加算できる', ->
      @user.addFp 100
      expect(@user.get('fp')).to.equal 100

    it 'fpを減算できる', ->
      @user.set 'fp', 100
      @user.addFp -50
      expect(@user.get('fp')).to.equal 50

  describe '#login', ->
    beforeEach ->
      @user = new Fmushi.Models.User

    it 'loggedInプロパティがtrueになる', ->
      @user.login()
      expect(@user.loggedIn).to.be.ok

    it 'attributesが更新される', ->
      @user.login name: 'hoge', fp: 100
      expect(@user.get('name')).to.eq('hoge')
      expect(@user.get('fp')).to.eq(100)

    it 'loginイベントが発火される', (done) ->
      @user.on 'login', ->
        done()
      @user.login()

  describe '#logout', ->
    beforeEach ->
      @user = new Fmushi.Models.User
      @user.login name: 'tofinity'

    it 'loggedInプロパティがfalseになる', ->
      @user.logout()
      expect(@user.loggedIn).to.not.be.ok

    it 'logoutイベントが発火する', (done) ->
      @user.on 'logout', ->
        done()
      @user.logout()
    