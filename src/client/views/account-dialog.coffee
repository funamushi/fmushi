class Fmushi.Views.AccountDialog extends Fmushi.Views.Base
  render: ->
    @setElement $(document.createElement('div')).attr
      id: 'account-dialog'
      class: 'control'
    @

  open: ->
    @close()

    @$el.popover 'show',
      html: true
      placement: 'bottom'
      trigger: 'manual'
      container: '#account'
      content: 'hoge'

  close: ->
    @$el.popover 'destroy'










