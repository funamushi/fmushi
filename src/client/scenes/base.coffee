Fmushi   = require 'fmushi'
BaseView = require 'views/base'

module.exports = class BaseScene extends BaseView
  el: '#content'
  keepElement: true

  constructor: ->
    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world
    @shapeWorld = Fmushi.two.makeGroup()

    $('#indicator').show()

    @on 'ready', ->
      $('#indicator').hide()
    super

  transitionIn: ->
    $.Deferred().resolve().promise()

  transitionOut: ->
    $.Deferred().resolve().promise()

  dispose: ->
    @$el.empty()

    Fmushi.stage.removeChild @world
    Fmushi.two.remove @shapeWorld

    super

