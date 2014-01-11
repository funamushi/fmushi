require './helper'

describe 'GET /ranks', ->
  it 'should respond with json', (done) ->
    request()
    .get('/ranks')
    .set('Accept', 'application/json')
    .expect('Content-Type', /json/)
    .expect(200, done)

  it '配列を返す', (done) ->
    request()
    .get('/ranks')
    .set('Accept', 'application/json')
    .end (err, res) ->
      json = JSON.parse(res.text)
      expect(json).to.be.instanceof(Array)
      done()
      