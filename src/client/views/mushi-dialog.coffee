BaseView = require 'views/base'
template = require 'templates/mushies/dialog'

module.exports = class MushiDialog extends BaseView
  tagName: 'div'
  className: 'control'
  attributes:
    id: 'mushi-dialog-origin'

  open: (mushi) ->
    @close()

    @$popover = $(@$el)
    .popover
      html: true
      placement: 'top'
      title: "#{mushi.get('name')}"
      trigger: 'manual'
      container: 'body'
      content: template
        mushi: mushi.toJSON()
        comment: mushi.comment()
    .popover 'show'

  close: ->
    @$popover?.popover 'destroy'
