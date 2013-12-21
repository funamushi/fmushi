require('coffee-script')

path    = require('path')
express = require('express')
hbs     = require('hbs')

routes = require('./routes')

module.exports = exports = app = express()

app.configure ->
  app.set 'port', process.env.PORT or 5000
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

app.get '/ranks',   routes.api.ranks.index
app.get '/items',   routes.api.items.index
app.get '/mushies', routes.api.mushies.index
app.get '/circles', routes.api.circles.index

app.get '/signup', routes.siginup
app.get '/signin', routes.signin

app.get '/', routes.home

app.startServer = ->
  app.listen app.get('port'), ->
    console.log "Fmushi server listening on port:#{app.get('port')}"
