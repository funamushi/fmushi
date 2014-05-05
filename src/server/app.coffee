require 'coffee-script'

path     = require 'path'
express  = require 'express'
hbs      = require 'hbs'
passport = require 'passport'

favicon      = require 'static-favicon'
compress     = require 'compression'
cookieParser = require 'cookie-parser'
session      = require 'express-session'
serveStatic  = require 'serve-static'

routes = require './routes'
config = require 'config'

module.exports = app = express()

RedisStore = require('connect-redis')(session)

app.set 'port', process.env.PORT or 3000
app.set "view engine", "hbs"
app.set 'views', path.join(__dirname, 'views')
app.set 'layout', 'layout'

app.use favicon(path.resolve './public/favicon.ico')
app.use compress()
app.use serveStatic(path.resolve "./public")
app.use cookieParser()
app.use session
  store: new RedisStore(url: config.redis.url)
  secret: '8d70fc7007c3068bb12217d9d89bb584ae2539e10f0563c0a1612df4e2bf8b6e' +
          '9416367d0044159b4be9af57292a8e8d6c47930574d8b63cae92a3b69c8281fb'
app.use passport.initialize()
app.use passport.session()

# if process.env.NODE_ENV is 'production'
#   app.use express.errorHandler()
#   app.use express.logger("dev")

app.get  '/viewer', routes.viewer.authorize, routes.viewer.show
app.post '/register', routes.viewer.register
app.post '/login', passport.authenticate('local'), routes.viewer.login
app.delete '/logout', routes.viewer.logout

app.get '/:user/mushies/:mushiId', routes.user.mushi
app.get '/:user.:format?', routes.user.show
app.put '/:user'

app.get '/*', routes.root

app.param 'format', routes.acceptOverride
app.param 'user',   routes.user.set

app.startServer = ->
  app.listen app.get('port'), ->
    console.log "Fmushi server listening on port:#{app.get('port')}"
