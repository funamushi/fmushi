User    = require 'models/user'
Camera  = require 'models/camera'
Breed   = require 'models/breed'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'
Stocks  = require 'collections/stocks'

module.exports = class Viewer extends User
  url: ->
    '/viewer'

  sync: (method, model, options={})->
    if method is 'read'
      Backbone.ajaxSync.call(@, method, model, options)
      .then =>
        if @isNew()
          Backbone.localSync.call(@, method, model, options)
    else
      if options.ajax
        Backbone.ajaxSync.call @, method, model, options
      else
        Backbone.localSync.call @, method, model, options
