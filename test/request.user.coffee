request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'GET /:user', ->
  describe 'json', ->
    it '指定した名前のユーザを返す', (done) ->
      request(app)
      .get('/hadashiA')
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        json = JSON.parse(res.text)
        expect(json.name).to.equal('hadashiA')
        done()

  describe 'html', ->
    it 'マイページを返す', (done) ->
      request(app)
      .get('/hadashiA')
      .set('Accept', 'text/html')
      .expect('Content-Type', /html/)
      .expect(/F虫/)
      .expect(200, done)

describe 'GET /:user/mushies', ->
  describe 'json', ->
    it 'ユーザが持っている虫のJSONを返す', (done) ->
      request(app)
      .get('/hadashiA/mushies')
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        json = JSON.parse(res.text)
        expect(json).to.be.instanceof(Array)
        done()

describe 'GET /:user/mushies/:id', ->
  describe 'html', ->
    it 'マイページを返す', (done) ->
      request(app)
      .get('/hadashiA/mushies/1')
      .set('Accept', 'text/html')
      .expect('Content-Type', /html/)
      .expect(200)
      .expect(/F虫/, done)

describe 'GET /:user/circles', ->
  describe 'json', ->
    it 'ユーザが持っている円のJSONを返す', (done) ->
      request(app)
      .get('/hadashiA/circles')
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        json = JSON.parse(res.text)
        expect(json).to.be.instanceof(Array)
        done()      