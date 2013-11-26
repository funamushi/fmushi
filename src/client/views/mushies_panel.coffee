class Fmushi.Views.MushiesPanel extends Backbone.View
  events:
    'click': ->
      console.log 'clicked'

  initialize: ->

  render: ->
    html = JST['mushies/panel'](mushies: @collection.toJSON())
    @$el.html(html)
    @