Fmushi = require 'fmushi'
BaseView   = require 'views/base'
Circle     = require 'models/circle'
CircleView = require 'views/circle'

buttonTemplate  = require 'templates/menu-item-button'
popoverTemplate = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'item'

  initialize: ->
    @listenTo @model, 'change:quantity', @onChangeQuantity

  render: ->
    $(@$el)
    .addClass("element-icon-#{@model.get 'item.element'}")
    .html(buttonTemplate stock: @model.toJSON())
    .tooltip
      html: true
      placement: 'bottom'
      title: popoverTemplate(stock: @model.toJSON())

    @$quantity = @$('.quantity')

    @hammer = Hammer(@el)
    .on 'dragstart', (e) =>
      {pageX, pageY} = e.gesture.srcEvent
      @model.open pageX, pageY

    .on 'drag', (e) =>
      if circle = @model.get('circle')
        {pageX, pageY} = e.gesture.center
        circle.set x: pageX, y: pageY

    .on 'dragend', (e) =>
      mouseOn = e.gesture.target
      button  = @$el[0]
      if button is mouseOn or $.contains(button, mouseOn)
        @model.close()
      else
        @model.use()
    @

  onChangeQuantity: (stock, quantity) ->
    @$quantity.text quantity

  dispose: ->
    super
    @hammer?.dispose()









