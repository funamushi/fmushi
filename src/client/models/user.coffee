Camera  = require 'models/camera'
Breed   = require 'models/breed'
Mushies = require 'collections/mushies'
Circles = require 'collections/circles'
Stocks  = require 'collections/stocks'

module.exports = class User extends Backbone.AssociatedModel
  defaults: ->
    fp: 0
    camera:  new Camera
    mushies: new Mushies
    circles: new Circles
    stocks:  new Stocks

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
    {
      type: Backbone.Many
      key: 'bookPages'
      relatedModel: Breed
    }
  ]

  url: ->
    "/#{@get 'name'}"

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

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
