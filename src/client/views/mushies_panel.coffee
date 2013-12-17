class Fmushi.Views.MushiesPanel extends Fmushi.Views.Base
  events:
    'mouseover a': 'point'
    'mouseout a':  'pointOut'
    'click a': 'focus'
    'tap a':   'focus'

  initialize: ->

  render: ->
    mushies = @collection.map (mushi) ->
      attr = mushi.toJSON()
      attr.rank = mushi.rank.toJSON()
      attr

    @$el.html JST['mushies/panel']
      mushies: mushies
    @

  point: (e) ->
    mushi = @mushiFromEvent(e)?.point()

  pointOut: (e) ->
    @mushiFromEvent(e)?.pointOut()

  focus: (e) ->
    e.preventDefault()
    @$('.list-group-item').removeClass('active')
    $(e.target).addClass('active')

    if mushi = @mushiFromEvent(e)
      Fmushi.app.focus mushi

  mushiFromEvent: (e) ->
    mushiId = $(e.target).data('mushi-id')
    @collection.findWhere(id: mushiId)
