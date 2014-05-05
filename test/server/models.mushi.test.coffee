require './helper'

{User, Breed, Mushi} = require '../../src/server/models'

describe Mushi, ->
  describe 'default value', ->

  describe 'eager loading', ->
    beforeEach ->
      User.create(name: 'hadashiA')
      .then (user) =>
        @user = user
        Breed.create(slug: 'boxing')
      .then (breed) ->
        mushi = Mushi.build()
        mushi.setUser @user
        mushi.setBreed breed
        mushi.save()
      .then (mushi) =>
        @mushi = mushi

    afterEach ->
      Mushi.destroy()
      .then ->
        Breed.destroy()
      .then ->
        User.destroy()

    it '', ->
      expect(1).to.be.eql(1)





