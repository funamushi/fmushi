class Fmushi.Models.Viewer extends Backbone.Model
  url: ->
    '/viewer'

  initialize: ->
    @authorized = false

  fetch: (options) ->
    super(options)
    .then =>
      @authorized = true
    , (res, result, data) =>
      if res.status is 401
        defer = $.Deferred()
        defer.resolve this, 'unauthorized', defer
 
        