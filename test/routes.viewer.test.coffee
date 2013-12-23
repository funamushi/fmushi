request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'GET /viewer', ->
  describe 'ログインしてない', ->
    it 'should be 401', (done) ->
      request(app)
      .get('/viewer')
      .set('Accept', 'application/json')
      .expect(401, done)
