Fmushi = require 'fmushi'
BaseView   = require 'views/base'
Circle     = require 'models/circle'
CircleView = require 'views/circle'

buttonTemplate  = require 'templates/menu-item-button'
popoverTemplate = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'item'

  events:
    'mousedown': 'onDragStart'
    'mouseup':   'onDragCancel'

  render: ->
    $(@$el)
    .addClass("element-icon-#{@model.get 'item.element'}")
    .html(buttonTemplate stock: @model.toJSON())
    .tooltip
      html: true
      placement: 'top'
      title: popoverTemplate(stock: @model.toJSON())
    @

  onDragStart: (e) ->
    @model.open(e.x, e.y)

  onDragCancel: (e) ->
    @model.close()

  onMouseOut: (e) ->
    