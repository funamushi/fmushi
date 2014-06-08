Fmushi   = require 'fmushi'
BaseView = require 'views/base'

module.exports = class MenuOwnMushiButtonView extends BaseView
  tagName: 'button'
  className: 'mushi own list-group-item btn btn-primary'
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

