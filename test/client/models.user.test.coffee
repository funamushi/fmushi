User    = require 'models/user'
Camera  = require 'models/camera'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'

describe User, ->
  describe 'defaults', ->
    beforeEach ->
      @user = new User

    it 'fpは0', ->
      expect(@user.get 'fp').to.eq(0)

    it 'cameraを持っている', ->
      expect(@user.get 'camera').to.be.instanceof(Camera)

    it '空のmushiesコレクションを持っている', ->
      expect(@user.get 'mushies').to.be.instanceof(Mushies)
      expect(@user.get('mushies').toJSON()).to.be.empty

    it '空のcirclesコレクションを持っている', ->
      expect(@user.get 'circles').to.be.instanceof(Circles)
      expect(@user.get('circles').toJSON()).to.be.empty
