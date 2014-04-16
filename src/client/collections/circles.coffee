Circle = require 'models/circle'

module.exports = class Circles extends Backbone.Collection
  model: Circle

  initialize: (models, options) ->
    @user = options.user

  url: ->
    @user.url() + '/circles'
  
