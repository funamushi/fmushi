describe Fmushi.Models.Mushi, ->
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









