class Fmushi.Views.MushiDialog extends Fmushi.Views.Base
  initialize: ->

  render: ->
    html = JST['mushies/dialog'](mushi: @model?.toJSON())
    @$el.html(html)
    @

  hide: ->
    @$el.hide()

  show: ->
    @$el.show()
