class Fmushi.Models.User extends Backbone.Model
  defaults:
    fp: 0

  initialize: ->
    @loggedIn = false

  url: ->
    "/#{@get('name')}"

  login: (attributes, options) ->
    @set attributes, options
    @loggedIn = true
    @trigger 'login', @ unless options?.silent?

  logout: (options) ->
    @clear()
    @set @defaults
    @loggedIn = false
    @trigger 'logout', @ unless options?.silent?

  validate: (attrs) ->
    errors = []

    if _.isEmpty(attrs.name)
      errors.push attr: 'name', message: '名前がありません。'

    if attrs.fp < 0
      errors.push attr: 'fp', message: '0以下にできません。'

    return errors if errors.length

  fetchViewer: (options={}) ->
    options.url = '/viewer'
    @fetch(options)
    .then (attrs, result, xhr) =>
      @login attrs
    , (res, result, data) =>
      if res.status is 401
        defer = $.Deferred()
        defer.resolve this, 'unauthorized', defer

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
