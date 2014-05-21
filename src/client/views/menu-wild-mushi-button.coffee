Fmushi   = require 'fmushi'
BaseView = require 'views/base'

template = require 'templates/item-popover'

module.exports = class MenuWildMushiButtonView extends BaseView
  tagName: 'button'
  className: 'mushi wild list-group-item btn btn-info'
  attributes:
    type: 'button'

  events:
    'mouseover': 'onPointIn'
    'mouseout':  'onPointOut'
    'click': 'onFocus'

  render: ->
    @$el
    .addClass("element-#{@model.get 'breed.element'}")
    .html("<strong>野生の</strong>#{@model.get 'breed.name'}")
    @

  onPointIn: (e) ->
    @model.point()

  onPointOut: (e) ->
    @model.pointOut()
  
  onFocus: (e) ->
    e.preventDefault()

    # FIXME: currentSceneがグローバルなのどうなの
    Fmushi.currentScene.focus @model

