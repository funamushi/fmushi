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
