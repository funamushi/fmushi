class Fmushi.Views.MushiDialog extends Fmushi.Views.Base
  render: ->
    html = JST['mushies/dialog']
      mushi: @model?.toJSON()
      rank: @model?.rank?.toJSON()
      comment: @model.comment()
      equipments: @model.equipments?.map (equipment) ->
        equipmentAttr = equipment.toJSON()
        equipmentAttr.item = equipment.item.toJSON()
        equipmentAttr
    @$el.html(html)
    @

  hide: ->
    @$el.hide()

  show: ->
    @$el.show()
