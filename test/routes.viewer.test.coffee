require './helper'

describe 'POST /login', ->
  describe 'ログイン成功', ->
    it 'ログインユーザのJSONを返す', (done) ->
      request()
      .post('/login')
      .send(username: 'hadashiA', password: 'hoge')
      .expect(200)
      .end (err, res) ->
        json = JSON.parse(res.text)
        expect(json.name).to.equal('hadashiA')
        done()

  describe 'ログイン失敗', ->
    it 'status 401', (done) ->
      request()
      .post('/login')
      .send(username: 'hadashiA', password: 'fuga')
      .expect(401, done)

describe 'GET /viewer', ->
  describe 'json', ->
    describe 'ログイン前', ->
      it 'should be 401', (done) ->
        request()
        .get('/viewer')
        .set('Accept', 'application/json')
        .expect(401, done)

    describe 'ログイン後', ->
      beforeEach (done) ->
        request()
        .post('/login')
        .send(username: 'hadashiA', password: 'hoge')
        .expect(200)
        .end (err, res) =>
          @cookie = res.headers['set-cookie']
          done()

      it 'status 200', (done) ->
        request()
        .get('/viewer')
        .set('Accept', 'application/json')
        .set('Cookie', @cookie)
        .expect(200, done)

  describe 'html', ->
    describe 'ログイン前', ->
      it 'should be 401', (done) ->
        request()
        .get('/viewer')
        .set('Accept', 'text/html')
        .expect(401, done)

    describe 'ログイン後', ->
      beforeEach (done) ->
        request()
        .post('/login')
        .send(username: 'hadashiA', password: 'hoge')
        .expect(200)
        .end (err, res) =>
          @cookie = res.headers['set-cookie']
          done()

      it 'ユーザのマイページへリダイレクト', (done) ->
        request()
        .get('/viewer')
        .set('Accept', 'text/html')
        .set('Cookie', @cookie)
        .expect(302)
        .expect(/\/hadashiA/, done)
