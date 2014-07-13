Fmushi   = require 'fmushi'
BaseView = require 'views/base'

template = require 'templates/item-popover'

module.exports = class MenuWildMushiButtonView extends BaseView
  tagName: 'button'
  className: 'mushi wild list-group-item blink'
  attributes:
    type: 'button'

  events:
    'mouseover': 'onPointIn'
    'mouseout':  'onPointOut'
    'click': 'onFocus'

  render: ->
    @$el.html("#{@model.get 'breed.name'}<span class=\"badge\">野生</span>")
    @

  onPointIn: (e) ->
    @model.point()

  onPointOut: (e) ->
    @model.pointOut()
  
  onFocus: (e) ->
    e.preventDefault()

    # FIXME: currentSceneがグローバルなのどうなの
    Fmushi.currentScene.zoomIn @model

