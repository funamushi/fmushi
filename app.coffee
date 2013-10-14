path = require('path')
express = require('express')
app = express()

app.engine 'html', require('hogan-express')

app.configure ->
  app.set "views", path.join(__dirname, "/views")
  app.set "view engine", "html"
  app.set 'layout', 'layout'
  app.use express.favicon()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure 'production', ->
  app.locals
    js: [
      { src: 'app.min.js' }
    ]

app.configure 'development', ->
  app.use express.errorHandler()
  app.use express.logger("dev")
  app.locals
    js: [
      { src: 'funamushi.js' }
    ]

app.get '/', (req, res) ->
  res.render 'index'

module.exports = app

if require.main == module
  app.listen 3000, ->
    console.log 'Express server listening on port:3000'
