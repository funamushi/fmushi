process.env.NODE_ENV = 'test'

supertest = require 'supertest'
app = require '../../src/server/app'

global.Q       = require 'q'
global.expect  = require('chai').expect
global.request = ->
  supertest(app)
    