class Fmushi.Views.MushiDialog extends Backbone.View
  initialize: ->

  render: ->
    html = JST['mushies/dialog'](mushi: @model?.toJSON())
    @setElement @$el.html(html)
    @

  hide: ->
    @$el.hide()

  show: ->
    @$el.show()
