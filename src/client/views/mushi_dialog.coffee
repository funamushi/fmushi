class Fmushi.Views.MushiDialog extends Fmushi.Views.Base
  el: '#mushi-dialog-origin'

  open: (mushi) ->
    weapon = mushi.equipments.findWhere(type: 'weapon')

    @$el.popover
      html: true
      placement: 'top'
      title: "#{mushi.get('name')} #{mushi.rank.get('name')}"
      trigger: 'manual'
      container: 'body'
      content: JST['mushies/dialog']
        mushi: mushi.toJSON()
        comment: mushi.comment()
        weapon: weapon?.toJSON()
        weaponItem: weapon?.item.toJSON()

    @$el.popover 'show'

  close: ->
    @$el.popover 'destroy'
