request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'POST /signin', ->
  describe 'ログイン成功', ->
    it 'ログインユーザのJSONを返す', (done) ->
      request(app)
      .post('/signin')
      .send(username: 'hadashiA', password: 'hoge')
      .expect(200)
      .end (err, res) ->
        json = JSON.parse(res.text)
        expect(json.name).to.equal('hadashiA')
        done()

  describe 'ログイン失敗', ->
    it 'status 401', (done) ->
      request(app)
      .post('/signin')
      .send(username: 'hadashiA', password: 'fuga')
      .expect(401, done)

describe 'GET /viewer', ->
  describe 'ログイン前', ->
    it 'should be 401', (done) ->
      request(app)
      .get('/viewer')
      .set('Accept', 'application/json')
      .expect(401, done)

  describe 'ログイン後', ->
    beforeEach (done) ->
      request(app)
      .post('/signin')
      .send(username: 'hadashiA', password: 'hoge')
      .expect(200)
      .end (err, res) ->
        @cookie = res.headers['set-cookie']
        done()

    it 'status 200', (done) ->
      request(app)
      .get('/viewer')
      .set('Accept', 'application/json')
      .set('Cookie', @cookie)
      .expect(200, done)
