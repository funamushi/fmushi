request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'GET /items', ->
  it 'should respond with json', (done) ->
    request(app)
    .get('/items')
    .set('Accept', 'application/json')
    .expect('Content-Type', /json/)
    .expect(200, done)

  it '配列を返す', (done) ->
    request(app)
    .get('/items')
    .set('Accept', 'application/json')
    .end (err, res) ->
      json = JSON.parse(res.text)
      expect(json).to.be.instanceof(Array)
      done()
      