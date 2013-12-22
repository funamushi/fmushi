request = require 'supertest'

{expect} = require 'chai'

app = require '../src/server/app'

describe 'GET /user', ->
  it 'respond with json', (done) ->
    request(app)
    .get('/user')
    .expect('Content-Type', /json/)
    .expect(200, done)

describe 'GET /circles', ->
  it 'respond with json', (done) ->
    request(app)
    .get('/circles')
    .expect('Content-Type', /json/)
    .expect(200, done)

describe 'GET /items', ->
  it 'respond with json', (done) ->
    request(app)
    .get('/items')
    .expect('Content-Type', /json/)
    .expect(200, done)

describe 'GET /mushies', ->
  it 'respond with json', (done) ->
    request(app)
    .get('/mushies')
    .expect('Content-Type', /json/)
    .expect(200, done)

describe 'GET /ranks', ->
  it 'respond with json', (done) ->
    request(app)
    .get('/ranks')
    .expect('Content-Type', /json/)
    .expect(200, done)
