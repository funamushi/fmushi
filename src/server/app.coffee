path    = require('path')
express = require('express')
hbs     = require('hbs')

require('coffee-script')

app = express()

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

app.get '/mushies', (req, res) ->
  res.send [
    { name: 'プヤプヤプンヤ', rank: '一等兵', x: 700,  y: 300 }
    { name: 'ヘイプー', rank: '大佐', x: 850,  y: 400 }
    { name: 'プンヤープヤプヤ', rank: '二等兵', x: 1000, y: 500 }
  ]

app.get '/circles', (req, res) ->
  res.send [
    { x: 100, y: 350, r: 300 }
  ]

app.startServer = ->
  app.listen app.get('port'), ->
    console.log "Fmushi server listening on port:#{app.get('port')}"
        
module.exports = exports = app
