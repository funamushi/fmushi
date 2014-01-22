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

    if _.isEmpty attrs.name
      errors.push attr: 'name', message: '名前がありません。'

    unless attrs.name.match /^[0-9A-Za-z]+$/
      errors.push attr: 'name', message: '半角英数字で入力して下さい。'

    if _.isEmpty attrs.password
      errors.push attr: 'password', message: '好きな言葉がありません。'

    if attrs.fp < 0
      errors.push attr: 'fp', message: '0以下にできません。'

    if errors.length > 0
      @trigger 'invalid', @, errors
      return errors

  fetchViewer: (options={}) ->
    options.url = '/viewer'
    @fetch(options)
    .then (attrs, result, xhr) =>
      @login attrs
    , (res, result, data) =>
      if res.status is 401
        defer = $.Deferred()
        defer.resolve this, 'unauthorized', defer

  register: (options={}) ->
    options.url    = '/register.json'
    options.silent = true

    @save({
      name: @get('name'),
      password: @get('password')
    }, options).then (data) =>
      console.log arguments
      @login data

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
