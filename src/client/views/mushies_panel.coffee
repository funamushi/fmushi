class Fmushi.Views.MushiesPanel extends Fmushi.Views.Base
  events:
    'mouseover a': 'pointIn'
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

  pointIn: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.point()

  pointOut: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.pointOut()

  focus: (e) ->
    e.preventDefault()
    if mushi = @mushiFromEvent(e)
      Fmushi.app.focus mushi

  mushiFromEvent: (e) ->
    mushiId = $(e.target).parents('li').data('mushi-id')
    @collection.findWhere(id: mushiId)
