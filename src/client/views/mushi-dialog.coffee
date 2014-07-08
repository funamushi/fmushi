Fmushi = require 'fmushi'
BaseView = require 'views/base'
template = require 'templates/mushi-dialog'

module.exports = class MushiDialog extends BaseView
  tagName: 'div'
  className: 'control'
  attributes:
    id: 'mushi-dialog-origin'

  events:
    'click .zoom-out': 'onFocusOut'

  open: (mushi) ->
    @close()

    @$popover = $(@$el)
    .popover
      html: true
      placement: 'top'
      title: "#{mushi.get 'breed.name'}"
      trigger: 'manual'
      container: @$el
      content: template
        mushi: mushi.toJSON()
        comment: mushi.comment()
    .popover 'show'

  close: ->
    @$popover?.popover 'destroy'

  onFocusOut: ->
    Fmushi.currentScene.zoomOut()
