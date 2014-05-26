Camera     = require 'models/camera'
Mushies    = require 'collections/mushies'
Circles    = require 'collections/circles'
Stocks = require 'collections/stocks'

module.exports = class User extends Backbone.AssociatedModel
  defaults: ->
    fp: 0
    camera:     new Camera
    mushies:    new Mushies
    circles:    new Circles
    stocks: new Stocks

  relations: [
    {
      type: Backbone.One
      key: 'camera'
      relatedModel: Camera
    }
    {
      type: Backbone.Many
      key: 'mushies'
      collectionType: Mushies
    }
    {
      type: Backbone.Many
      key: 'circles'
      collectionType: Circles
    }
    {
      type: Backbone.Many
      key: 'stocks'
      collectionType: Stocks
    }
  ]

  url: ->
    "/#{@get 'name'}"

  optionalUrls:
    viewer: '/viewer'
    signup: '/signup'

  validate: (attrs) ->
    errors = []

    if _.isEmpty attrs.name
      errors.push attr: 'name', message: '名前がありません。'

    unless attrs.name.match /^[0-9A-Za-z]+$/
      errors.push attr: 'name', message: '半角英数字で入力して下さい。'

    if attrs.fp < 0
      errors.push attr: 'fp', message: '0以下にできません。'

    if errors.length > 0
      @trigger 'invalid', @, errors
      return errors

  fetchViewer: (options={}) ->
    options.url = @optionalUrls.viewer
    @fetch(options).done =>
      @loggedIn = @has('name')

  save: (key, val, options) ->
    if key == null or typeof key is 'object'
      attrs = key
      options = val
    else
      (attrs = {})[key] = val

    options ?= {}
    options.url ?= @optionalUrls.viewer
    super attrs, options

  signup: (options={}) ->
    options.url = @optionalUrls.signup
    @save null, options

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
