User    = require 'models/user'
Camera  = require 'models/camera'
Breed   = require 'models/breed'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'
Stocks  = require 'collections/stocks'

module.exports = class Viewer extends User
  localStorage: new Backbone.LocalStorage('User')

  url: ->
    '/viewer'

  sync: (method, model, options)->
    if method is 'read'
      Backbone.ajaxSync.call(@, method, model, options)
      .then =>
        unless @isRegistered()
          Backbone.localSync.call(@, method, model, options)
    else
      if @isRegistered()
        Backbone.ajaxSync.call @, method, model, options
      Backbone.localSync.call @, method, model, options

  isRegistered: ->
    @has 'name'