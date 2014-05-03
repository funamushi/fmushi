Fmushi   = require 'fmushi'
BaseView = require 'views/base'
template = require 'templates/menu'

module.exports = class MenuView extends BaseView
  events:
    'click #menu-toggle-button': 'onToggleMenu'
    'mouseover #user-mushies a': 'onPointIn'
    'mouseout  #user-mushies a': 'onPointOut'
    'click     #user-mushies a': 'onFocus'
    'touchend  #user-mushies a': 'onFocus'

  initialize: ->
    mushies = @model.get('mushies')

    @listenTo mushies, 'focus:in', (mushi) ->
      @$('.list-group-item').each ->
        $this = $(@)
        if $this.data('mushi-id') is mushi.get('id')
          $this.addClass 'active'
        else
          $this.removeClass 'active'

    @listenTo mushies, 'focus:out', ->
      @$('.list-group-item').removeClass('active')

  render: ->
    @setElement template(user: @model.toJSON())

    @$icon       = $(@$('#menu-toggle-button').find('.glyphicon'))
    @$belongings = @$('#user-belongings')
    @$mushies    = @$('#user-mushies')
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
    @model.get('mushies').findWhere(id: mushiId)
