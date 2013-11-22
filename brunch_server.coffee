{exists} = require('fs')
{EventEmitter} = require('events')
{basename, resolve, join} = require('path')
{filter} = require('async')
http = require('http')
cordell = require('cordell')

{config} = require('./config')

class BrunchServer extends EventEmitter
  constructor: (config) ->
    @config = {}
    @config[k] = v for k, v of config.server
    throw 'Must specify an app location under config.server.app' unless @config.app?
    @app = require(resolve(@config.app))
    @server = http.createServer(@app)
    # @_debug = if @config.debug? require('debug')("#{@config.debug}") else ->

  start: (port, callback) ->
    @server.listen port, callback
    if @config.watched?
      filter @config.watched, exists, (files) =>
        @ranger = cordell.ranger files, @config
        @ranger.on 'end', (files, stats) =>
          setTimeout =>
            @ranger.on 'add', =>
              @reload()
            @ranger.on 'rem', =>
              @reload()
            @ranger.on 'change', =>
              @reload()
          , 1000
        @ranger.on 'error', (path, err) => 
          @config.ingore
          if !@config.ignore or !@config.ignore.test(basename(path))
            @emit 'error', path, err

      @emit 'start', @

  stop: (fn) ->
    console.log 'Stopping...'
    @server.close fn
    @watcher.close()
    @emit 'stop', @

  reload: ->
    console.log 'Reloading...'
    @app = require(resolve(@config.app))
    @emit 'reload', @

  close: (fn) ->
    @stop fn

module.exports = exports = BrunchServer

module.exports.startServer = (port, path, callback) ->
  server = new BrunchServer(config)
  # io = require('socket.io').listen server.server, logger: server.logger
  # io.set 'log level', 2 
  # sockets = require('./express/sockets')(io)

  # server.on 'reload', ->
  #     sockets.emit '/brunch/reload', 1000
  #     sockets.destroy()
  #     sockets = require('./express/sockets')(io)

  server.start(port, callback)
  server