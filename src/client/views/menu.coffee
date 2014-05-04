Fmushi   = require 'fmushi'
BaseView = require 'views/base'
template = require 'templates/menu'

module.exports = class MenuView extends BaseView
  tagName: 'div'
  className: 'control'
  attributes:
    id: 'menu'

  events:
    'click .toggle-button': 'onToggleMenu'
    'mouseover .mushies .btn': 'onPointIn'
    'mouseout  .mushies .btn': 'onPointOut'
    'click     .mushies .btn': 'onFocus'

  initialize: (options) ->
    @owner       = options.owner
    @wildMushies = options.wildMushies

    @listenTo @owner.get('mushies'), 'add', @render
    @listenTo @owner.get('belongings'), 'add', @render
    @listenTo @wildMushies, 'add', @render

  render: ->

    @$el.html template
      owner: @owner.toJSON()
      wildMushies: @wildMushies.map (mushi) ->
        json = mushi.toJSON()
        json.cid = mushi.cid
        json

    @$icon       = $(@$('.toggle-button').find('.glyphicon'))
    @$belongings = @$('.belongings')
    @$mushies    = @$('.mushies')
    @open = true
    @

  onPointIn: (e) ->
    @mushiFromEvent(e)?.point()

  onPointOut: (e) ->
    @mushiFromEvent(e)?.pointOut()

  onFocus: (e) ->
    e.preventDefault()

    mushi = @mushiFromEvent(e)
    Fmushi.scene.focus mushi

  onToggleMenu: (e) ->
    e.preventDefault()

    return if @menuLocked
    @menuLocked = true

    if @open
      @$icon.transition {rotate: '180deg'}, 200, 'easeInOutSine', =>
        @$belongings.hide()
        @$mushies.hide()
        @$icon
        .removeClass('glyphicon-minus')
        .addClass('glyphicon-plus')

        @open = false
        @menuLocked = false
    else
      @$icon.transition {rotate: '0deg'}, 200, 'easeInOutSine', =>
        @$belongings.show()
        @$mushies.show()
        @$icon
        .removeClass('glyphicon-plus')
        .addClass('glyphicon-minus')

        @open = true
        @menuLocked = false
      
  mushiFromEvent: (e) ->
    mushiId = $(e.target).data('mushi-id')
    @owner.get('mushies').get(mushiId) or
      @wildMushies.get(mushiId)
