class Fmushi.Views.MushiesPanel extends Backbone.View
  events:
    'mouseover a': @onPointIn
    'mouseout a': @onPointOut
    'click a': @onClick

  initialize: ->

  render: ->
    html = JST['mushies/panel'](mushies: @collection.toJSON())
    @setElement @$el.html(html)
    @delegateEvents
      'mouseover a': @onPointIn
      'mouseout a':  @onPointOut
      'click a': @onClick
    @

  onPointIn: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.trigger 'point:in'

  onPointOut: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.trigger 'point:out'

  onClick: (e) ->
    if mushi = @mushiFromEvent(e)
      mushi.trigger 'point:out'
      Fmushi.app.focus mushi

  mushiFromEvent: (e) ->
    mushiId = $(e.target).parents('li').data('mushi-id')
    @collection.findWhere(id: mushiId)
