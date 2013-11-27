class Fmushi.Views.MushiesPanel extends Backbone.View
  events:
    'mouseover a': 'pointIn'
    'mouseout a':  'pointOut'
    'click a': 'focus'
    'tap a':   'focus'

  initialize: ->

  render: ->
    @$el.html JST['mushies/panel'](mushies: @collection.toJSON())
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
