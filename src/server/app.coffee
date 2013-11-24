path    = require('path')
express = require('express')
hbs     = require('hbs')

app = express()

app.configure ->
  app.set "view engine", "hbs"
  app.set 'views', path.join(__dirname, 'views')
  app.set 'layout', 'layout'
  app.use express.favicon()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.resolve("./public"))

app.configure 'production', ->

app.configure 'development', ->
  app.use express.errorHandler()
  app.use express.logger("dev")

app.get '/', (req, res) ->
  res.render 'index'

app.get '/mushies', (req, res) ->
  res.send [
    { x: 700,  y: 300 }
    { x: 850,  y: 400 }
    { x: 1000, y: 500 }
  ]

app.get '/circles', (req, res) ->
  res.send [
    { x: 100, y: 350, r: 300 }
  ]

module.exports = exports = app

exports.startServer = startServer = ->
  app.listen 3000, ->
    console.log 'Express server listening on port:3000'

startServer() if module.parent == null
        
