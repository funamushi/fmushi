BaseView = require 'views/base'
template = require 'templates/mushies/panel'

module.exports = class MushiesPanelView extends BaseView
  events:
    'mouseover a': 'point'
    'mouseout a':  'pointOut'
    'click a': 'focus'
    'touchend a':   'focus'

  initialize: (options) ->
    @owner = options.owner

    @listenTo @collection, 'focus:in', (mushi) ->
      @$('.list-group-item').each ->
        $this = $(@)
        if $this.data('mushi-id') is mushi.get('id')
          $this.addClass 'active'
        else
          $this.removeClass 'active'

    @listenTo @collection, 'focus:out', ->
      @$('.list-group-item').removeClass('active')

  render: ->
    mushies = @collection.map (mushi) ->
      attr = mushi.toJSON()
      attr.rank = mushi.rank?.toJSON()
      attr

    @setElement template
      owner: @owner.toJSON()
      mushies: mushies
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
