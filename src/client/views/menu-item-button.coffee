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
      {pageX, pageY} = e.gesture.srcEvent
      @model.open pageX, pageY

    .on 'drag', (e) =>
      if circle = @model.get('circle')
        {pageX, pageY} = e.gesture.center
        circle.set x: pageX, y: pageY
    @

  dispose: ->
    Hammer(@$el[0]).off()





