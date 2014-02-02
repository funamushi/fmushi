require 'coffee-script'

path     = require 'path'
express  = require 'express'
hbs      = require 'hbs'
passport = require 'passport'

models = require './models'
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
  app.use express.cookieParser()
  app.use express.session secret: '8d70fc7007c3068bb12217d9d89bb584ae2539e10f0563c0a1612df4e2bf8b6e9416367d0044159b4be9af57292a8e8d6c47930574d8b63cae92a3b69c8281fb'
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router

app.configure 'production', ->
  app.use express.logger("dev")

app.configure 'development', ->
  app.use express.errorHandler()
  app.use express.logger("dev")

app.get '/ranks.:format?', routes.ranks.index
app.get '/items.:format?', routes.items.index

app.get  '/viewer.:format?', routes.viewer.authorize, routes.viewer.show
app.post '/register.:format?', routes.viewer.register
app.post '/login.:format?', passport.authenticate('local'), routes.viewer.login
app.delete '/logout', routes.viewer.logout

app.get '/:user.:format?',         routes.user.show
app.get '/:user/mushies.:format?', routes.user.mushies.index
app.get '/:user/circles.:format?', routes.user.circles.index

app.get '/*', routes.root

app.param 'format', routes.acceptOverride
app.param 'user',   routes.user.findByName

app.startServer = ->
  app.listen app.get('port'), ->
    console.log "Fmushi server listening on port:#{app.get('port')}"
