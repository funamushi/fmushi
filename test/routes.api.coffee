request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'GET /circles', ->
  it 'should be success', (done) ->
    request(app)
    .get('/circles')
    .expect(200, done)

describe 'GET /items', ->
  it 'should be success', (done) ->
    request(app)
    .get('/items')
    .expect(200, done)

describe 'GET /mushies', ->
  it 'should be success', (done) ->
    request(app)
    .get('/mushies')
    .expect(200, done)

describe 'GET /ranks', ->
  it 'should be success', (done) ->
    request(app)
    .get('/ranks')
    .expect(200, done)
