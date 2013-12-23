require 'coffee-script'

path    = require 'path'
express = require 'express'
hbs     = require 'hbs'

routes = require './routes'

module.exports = exports = app = express()

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set "view engine", "hbs"
  app.set 'views', path.join(__dirname, 'views')
  app.set 'layout', 'layout'
  app.use express.favicon()
  app.use express.compress()
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use express.static(path.resolve("./public"))
  app.use app.router

app.configure 'production', ->
  app.use express.logger("dev")

app.configure 'development', ->
  app.use express.errorHandler()
  app.use express.logger("dev")

app.get '/', (req, res) ->
  res.redirect '/hadashiA'

app.get '/ranks.:format?', routes.ranks.index
app.get '/items.:format?', routes.items.index

app.get '/:user.:format?',         routes.user.show
app.get '/:user/mushies.:format?', routes.user.mushies.index
app.get '/:user/circles.:format?', routes.user.circles.index

app.get '/*', routes.root

app.param 'format', routes.acceptOverride
app.param 'user',   routes.user.filter

app.startServer = ->
  app.listen app.get('port'), ->
    console.log "Fmushi server listening on port:#{app.get('port')}"
