require './helper'

{User, Identity, Mushi, Breed, Item, Stock} =
  require '../../src/server/models'

describe 'GET /:user', ->
  before ->
    User.create name: 'hadashiA'
    .then (user) =>
      @user = user
      Item.create slug: 'red-circle', element: 'red'
    .then (item) =>
      Stock.create userId: @user.id, itemId: item.id
    .then (stock) ->
      Breed.create slug: 'boxing', element: 'red'
    .then (breed) =>
      Mushi.create userId: @user.id, breedId: breed.id
    .then (mushi) =>
      Identity.create userId: @user.id, provider: 'twitter', uid: 'abcde'

  after ->
    clean(Mushi, Stock, Identity).then ->
      clean(Breed, Item, User)

  describe '存在するユーザ名', ->
    describe 'json', ->
      it '指定した名前のユーザを返す', (done) ->
        request()
        .get('/hadashiA')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .end (err, res) ->
          json = JSON.parse(res.text)
          expect(json.name).to.equal('hadashiA')
          expect(json.fp).to.equal(0)
          expect(json.identities[0].provider).to.equal('twitter')
          expect(json.mushies[0].direction).to.equal('left')
          expect(json.mushies[0].breed.slug).to.equal('boxing')
          expect(json.stocks[0].quantity).to.equal(1)
          expect(json.stocks[0].item.slug).to.equal('red-circle')
          done()

    describe 'html', ->
      it 'マイページを返す', (done) ->
        request()
        .get('/hadashiA')
        .set('Accept', 'text/html')
        .expect('Content-Type', /html/)
        .expect(/F虫/)
        .expect(200, done)

  describe '存在しないユーザ名', ->
    describe 'json', ->
      it '404', (done) ->
        request()
        .get('/hadashiZ')
        .set('Accept', 'application/json')
        .expect(404, done)

    describe 'html', ->
      it '404', (done) ->
        request()
        .get('/hadashiZ')
        .set('Accept', 'text/html')
        .expect(404, done)

describe 'GET /:user/mushies/:id', ->
  before ->
    User.create name: 'hadashiA'

  after ->
    clean User

  describe 'html', ->
    it 'マイページを返す', (done) ->
      request()
      .get('/hadashiA/mushies/1')
      .set('Accept', 'text/html')
      .expect('Content-Type', /html/)
      .expect(200)
      .expect(/F虫/, done)

describe 'POST /signup', ->
  describe 'セッションにOAuth情報がない場合', ->
    it 'status 422', (done) ->
      request()
      .post('/signup')
      .expect(422, done)
    
    
