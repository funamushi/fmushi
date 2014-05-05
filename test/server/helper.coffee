process.env.NODE_ENV = 'test'

Q         = require 'q'
_         = require 'lodash'
chai      = require 'chai'
supertest = require 'supertest'

models = require '../../src/server/models'
app    = require '../../src/server/app'

global.Q       = Q
global.expect  = chai.expect

global.request = ->
  supertest(app)

global.clean = (array) ->
  unless _.isArray(array)
    array = Array.prototype.slice.call(arguments, 0)

  Q.all _.map(array, (klass) ->
    klass.destroy()
  )
  
  