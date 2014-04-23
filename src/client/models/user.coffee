Camera  = require 'models/camera'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'

module.exports = class User extends Backbone.AssociatedModel
  defaults: ->
    fp: 0

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
  ]

  initialize: ->
    @loggedIn = false

  url: ->
    name = @get 'name'
    if name?
      "/#{@get('name')}"
    else
      '/'

  optionalUrls:
    viewer: '/viewer'

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
    options.url = @optionalUrls.viewer
    @fetch(options)

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
