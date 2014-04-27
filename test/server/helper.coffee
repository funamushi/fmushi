process.env.NODE_ENV = 'test'

supertest = require 'supertest'
app = require '../../src/server/app'

global.expect  = require('chai').expect
global.request = ->
  supertest(app)
    