class Fmushi.Views.MushiDialog extends Fmushi.Views.Base
  render: ->
    html = JST['mushies/dialog']
      mushi: @model?.toJSON()
      rank: @model?.rank?.toJSON()
      comment: @model.comment()
    @$el.html(html)
    @

  hide: ->
    @$el.hide()

  show: ->
    @$el.show()
