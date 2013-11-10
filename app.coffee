path    = require('path')
express = require('express')
hbs     = require('hbs')

app = express()

app.configure ->
  app.set "view engine", "hbs"
  app.set 'layout', 'layout'
  app.use express.favicon()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure 'production', ->
  app.locals
    js: [
      'app.min'
    ]

app.configure 'development', ->
  app.use express.errorHandler()
  app.use express.logger("dev")
  app.locals require('manifest.json')

app.get '/', (req, res) ->
  res.render 'index'

app.listen 3000, ->
  console.log 'Express server listening on port:3000'
