require './helper'

{User, Breed, Mushi} = require '../../src/server/models'

describe Mushi, ->
  describe 'default value', ->

  describe 'JSON', ->
    beforeEach ->
      User.create(name: 'hadashiA')
      .then (user) =>
        @user = user
        Breed.create(slug: 'boxing')
      .then (breed) =>
        @breed = breed
        Mushi.create userId: @user.id, breedId: @breed.id

    afterEach ->
      Mushi.destroy()
      .then ->
        Breed.destroy()
      .then ->
        User.destroy()

    it 'breedを内包するJSONを返す', ->
      Mushi.find
        where: ['true']
        include: [Breed]
      .then (mushi) =>
        json = JSON.parse JSON.stringify(mushi)
        expect(json.breed.id).to.eq(@breed.id)
        expect(json.breed.slug).to.eq(@breed.slug)
