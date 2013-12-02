class Fmushi.Views.MushiesPanel extends Fmushi.Views.Base
  events:
    'mouseover a': 'pointIn'
    'mouseout a':  'pointOut'
    'click a': 'focus'
    'tap a':   'focus'

  initialize: ->

  render: ->
    mushies = @collection.map (mushi) ->
      json = mushi.toJSON()
      json.rank = mushi.rank.toJSON()
      json

    @$el.html JST['mushies/panel']
      mushies: mushies
    @

  pointIn: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.trigger 'point:in'

  pointOut: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.trigger 'point:out'

  focus: (e) ->
    if mushi = @mushiFromEvent(e)
      Fmushi.app.focus mushi

  mushiFromEvent: (e) ->
    mushiId = $(e.target).parents('li').data('mushi-id')
    @collection.findWhere(id: mushiId)
