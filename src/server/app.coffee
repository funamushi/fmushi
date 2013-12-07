path    = require('path')
express = require('express')
hbs     = require('hbs')

require('coffee-script')

app = express()

E = {
  WEAPON1: 1  
}

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set "view engine", "hbs"
  app.set 'views', path.join(__dirname, 'views')
  app.set 'layout', 'layout'
  app.use express.favicon()
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.resolve("./public"))

app.configure 'production', ->
  app.use express.logger("dev")

app.configure 'development', ->
  app.use express.errorHandler()
  app.use express.logger("dev")

app.get '/', (req, res) ->
  res.render 'index'

app.get '/ranks', (req, res) ->
  res.send [
    { id: 1, level: 1, name: '一等兵' }
    { id: 2, level: 2, name: '大佐' }
    { id: 3, level: 3, name: 'ピストル原理主義者' }
  ]

app.get '/items', (req, res) ->
  res.send [
    { id: 1, name: '豆4カスタム', desc: 'めちゃ強な銃を強めた品' }
    { id: 2, name: '豆92F', desc: 'まじ強い銃' }
  ]

app.get '/mushies', (req, res) ->
  res.send [
    {
      id: 1
      name: 'プヤプヤプンヤ'
      rankId: 1
      x: 700
      y: 300
      equipments: [
        { type: E.WEAPON, itemId: 1 }
      ]
    }
    {
      id: 2,
      name: 'ヘイプー'
      rankId: 2
      x: 850
      y: 400
    }
    {
      id: 3
      name: 'がちゅん'
      rankId: 3
      x: 1000
      y: 500,
      equipments: [
        { type: E.WEAPON, itemId: 2 }
      ]
    }
  ]

app.get '/circles', (req, res) ->
  res.send [
    { id: 1, x: 500, y: 350, r: 200 }
  ]

app.startServer = ->
  app.listen app.get('port'), ->
    console.log "Fmushi server listening on port:#{app.get('port')}"
        
module.exports = exports = app
