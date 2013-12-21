{expect} = require 'chai'

app = require '../src/server/app'

describe 'GET /mushies', ->
  it 'hoge', (done) ->
    expect(1).to.equal(1)
    done()