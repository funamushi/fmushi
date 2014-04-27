require './helper'

describe 'GET /:user', ->
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
        done()

  describe 'html', ->
    it 'マイページを返す', (done) ->
      request()
      .get('/hadashiA')
      .set('Accept', 'text/html')
      .expect('Content-Type', /html/)
      .expect(/F虫/)
      .expect(200, done)

describe 'GET /:user/mushies/:id', ->
  describe 'html', ->
    it 'マイページを返す', (done) ->
      request()
      .get('/hadashiA/mushies/1')
      .set('Accept', 'text/html')
      .expect('Content-Type', /html/)
      .expect(200)
      .expect(/F虫/, done)
