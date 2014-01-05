class Fmushi.Views.MushiDialog extends Fmushi.Views.Base
  render: ->
    @setElement $(document.createElement('div')).attr
      id: 'mushi-dialog-origin'
      class: 'control'
    @

  open: (mushi) ->
    @close()
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
