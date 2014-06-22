Fmushi = require 'fmushi'
BaseView   = require 'views/base'
Circle     = require 'models/circle'
CircleView = require 'views/circle'

buttonTemplate  = require 'templates/menu-item-button'
popoverTemplate = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'item'

  initialize: (options) ->
    @camera = options.camera
    @listenTo @model, 'change:quantity', @onChangeQuantity

  render: ->
    $(@$el)
    .addClass("element-icon-#{@model.get 'item.element'}")
    .html(buttonTemplate stock: @model.toJSON())
    .tooltip
      html: true
      placement: 'top'
      title: popoverTemplate(stock: @model.toJSON())

    @$quantity = @$('.quantity')

    @hammer = Hammer(@el)
    .on 'dragstart', (e) =>
      x = @camera.worldX(e.gesture.srcEvent.clientX)
      y = @camera.worldY(e.gesture.srcEvent.clientY)
      @model.open x, y

    .on 'drag', (e) =>
      if circle = @model.get('circle')
        x = @camera.worldX(e.gesture.srcEvent.clientX)
        y = @camera.worldY(e.gesture.srcEvent.clientY)
        circle.set x: x, y: y

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

  gesturePosWithCameraOffset: (e) ->
    {clientX, clientY} = e.gesture.srcEvent
    center = Fmushi.windowCenter
    offsetX = @camera.get('x') - center.x
    offsetY = @camera.get('y') - center.y
    { x: clientX + offsetX, y: clientY + offsetY }

  dispose: ->
    super
    @hammer?.dispose()
