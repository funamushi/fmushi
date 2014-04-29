Fmushi   = require 'fmushi'
BaseView = require 'views/base'
template = require 'templates/menu'

module.exports = class MenuView extends BaseView
  events:
    'mouseover a': 'point'
    'mouseout a':  'pointOut'
    'click a': 'focus'
    'touchend a':   'focus'

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
    @

  point: (e) ->
    mushi = @mushiFromEvent(e)?.point()

  pointOut: (e) ->
    @mushiFromEvent(e)?.pointOut()

  focus: (e) ->
    e.preventDefault()
    mushi = @mushiFromEvent(e)
    Fmushi.scene.focus mushi

  mushiFromEvent: (e) ->
    mushiId = $(e.target).data('mushi-id')
    @collection.findWhere(id: mushiId)
