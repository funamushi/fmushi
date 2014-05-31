Fmushi = require 'fmushi'
BaseView   = require 'views/base'
Circle     = require 'models/circle'
CircleView = require 'views/circle'

buttonTemplate  = require 'templates/menu-item-button'
popoverTemplate = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'item'

  render: ->
    $(@$el)
    .addClass("element-icon-#{@model.get 'item.element'}")
    .html(buttonTemplate stock: @model.toJSON())
    .tooltip
      html: true
      placement: 'top'
      title: popoverTemplate(stock: @model.toJSON())

    Hammer(@$el[0])
    .on 'dragstart', (e) =>
      @model.open e.gesture.deltaX, e.gesture.deltaY

    .on 'drag', (e) =>
      if circle = @model.get('circle')
        x = circle.get('x') + e.gesture.deltaX
        y = circle.get('y') + e.gesture.deltaY
        circle.set x: x, y: y
    @

  dispose: ->
    Hammer(@$el[0]).off()