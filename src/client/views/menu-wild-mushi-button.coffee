Fmushi   = require 'fmushi'
BaseView = require 'views/base'

template = require 'templates/item-popover'

module.exports = class MenuWildMushiButtonView extends BaseView
  tagName: 'button'
  className: 'mushi wild list-group-item btn palette palette-silver'
  attributes:
    type: 'button'

  events:
    'mouseover': 'onPointIn'
    'mouseout':  'onPointOut'
    'click': 'onFocus'

  render: ->
    @$el.html("<span class=\"blink\"><strong>野生の</strong>#{@model.get 'breed.name'}</span>")
    @

  onPointIn: (e) ->
    @model.point()

  onPointOut: (e) ->
    @model.pointOut()
  
  onFocus: (e) ->
    e.preventDefault()

    # FIXME: currentSceneがグローバルなのどうなの
    Fmushi.currentScene.focus @model

