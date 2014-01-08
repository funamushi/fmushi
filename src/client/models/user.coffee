class Fmushi.Models.User extends Backbone.Model
  defaults:
    fp: 0

  initialize: ->
    @authorized = false

  url: ->
    "/#{@get('name')}"

  set: (key, val, options) ->
    if typeof key is 'object'
      attrs = key
      options = val
    else
      (attrs = {})[key] = val

    @aurhorized = true if options?.authorized

    super attrs, options

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
    .then =>
      @authorized = true
    , (res, result, data) =>
      if res.status is 401
        defer = $.Deferred()
        defer.resolve this, 'unauthorized', defer

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
