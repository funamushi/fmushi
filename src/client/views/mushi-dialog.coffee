BaseView = require 'views/base'
template = require 'templates/mushies/dialog'

module.exports = class MushiDialog extends BaseView
  tagName: 'div'
  className: 'control'
  attributes:
    id: 'mushi-dialog-origin'

  render: ->
    @

  open: (mushi) ->
    @close()

    @$el.popover
      html: true
      placement: 'top'
      title: "#{mushi.get('name')}"
      trigger: 'manual'
      container: 'body'
      content: template
        mushi: mushi.toJSON()
        comment: mushi.comment()

    @$el.popover 'show'

  close: ->
    @$el.popover 'destroy'



