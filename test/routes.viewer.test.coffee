request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'POST /signin', ->
  describe 'ログイン成功', ->
    it 'ログインユーザのJSONを返す', (done) ->
      request(app)
      .post('/signin')
      # .send('user[name]': 'hadashiA', 'user[password]': 'hoge')
      .send('user[name]': 'hadashiA', 'user[password]': 'hoge')
      .expect(200)
      .expect('success', done)

describe 'GET /viewer', ->
  describe 'ログイン前', ->
    it 'should be 401', (done) ->
      request(app)
      .get('/viewer')
      .set('Accept', 'application/json')
      .expect(401, done)
