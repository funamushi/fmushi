Fmushi   = require 'fmushi'
BaseView = require 'views/base'

module.exports = class MenuOwnMushiButtonView extends BaseView
  tagName: 'button'
  className: 'list-group-item btn btn-info'
  attributes:
    type: 'button'

  events:
    'mouseover': 'onPointIn'
    'mouseout':  'onPointOut'
    'click': 'onFocus'

  render: ->
    @$el.text(@model.get 'breed.name')
    @

  onPointIn: (e) ->
    @model.point()

  onPointOut: (e) ->
    @model.pointOut()
  
  onFocus: (e) ->
    e.preventDefault()

    # FIXME: currentSceneがグローバルなのどうなの
    Fmushi.currentScene.focus @model

