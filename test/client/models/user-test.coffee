describe Fmushi.Models.Mushi, ->
  describe '.fetchViewer', ->
    beforeEach ->
      @user = new Fmushi.Models.User

    describe 'ログインしている場合', ->
      beforeEach ->
        @server = sinon.fakeServer.create()
        @server.respondWith 'GET', '/viewer', [
          200,
          { 'Content-Type': 'application/json' },
          JSON.stringify { name: 'hadashiA', fp: 100 }
        ]

      afterEach ->
        @server.restore()

      it 'login()が呼ばれる', ->
        sinon.spy @user, 'login'
        @user.fetchViewer()
        @server.respond()

        expect(@user.login).to.been.calledOnce
        @user.login.restore()

      it 'attributesが更新される', ->
        @user.fetchViewer()
        @server.respond()
        expect(@user.get 'name').to.eq('hadashiA')
        expect(@user.get 'fp').to.eq(100)

    describe 'ログインしてない場合', ->
      beforeEach ->
        @server = sinon.fakeServer.create()
        @server.respondWith 'GET', '/viewer', [
          401,
          { 'Content-Type': 'application/json' }
          '{}'
        ]

      afterEach ->
        @server.restore()

      it 'login()は呼ばれない', ->
        sinon.spy @user, 'login'
        @user.fetchViewer()
        @server.respond()

        expect(@user.login).to.not.been.colled
        @user.login.restore()

      it 'attributeは変更されない', ->
        @user.fetchViewer()
        @server.respond()
        expect(@user.get 'name').to.be.empty

  describe '#validate', ->
    beforeEach ->
      @user = new Fmushi.Models.User name: 'hoge', password: 'hoge', fp: 100

    describe 'name', ->
      it '空にできない', (done) ->
        @user.on 'invalid', (user, errors) ->
          expect(errors[0].attr).to.equal('name')
          done()

        @user.set 'name', ''
        expect(@user.isValid()).to.not.be.ok

      it '全角文字は使えない', (done) ->
        @user.on 'invalid', (user, errors) ->
          expect(errors[0].attr).to.equal('name')
          done()

        @user.set 'name', 'あいえうお'
        expect(@user.isValid()).to.not.be.ok

    describe 'password', ->
      it '空にできない', (done) ->
        @user.on 'invalid', (user, errors) ->
          expect(errors[0].attr).to.equal('password')
          done()

        @user.set 'password', ''
        expect(@user.isValid()).to.not.be.ok

    describe 'fp', ->
      it '0未満にできない', (done) ->
        @user.on 'invalid', (user, errors) ->
          expect(errors[0].attr).to.equal('fp')
          done()

        @user.set 'fp', -1
        expect(@user.isValid()).to.not.be.ok

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
