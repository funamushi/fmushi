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
      x = @camera.worldX(e.gesture.srcEvent.pageX)
      y = @camera.worldY(e.gesture.srcEvent.pageY)
      @model.open x, y

    .on 'drag', (e) =>
      if circle = @model.get('circle')
        x = @camera.worldX(e.gesture.srcEvent.pageX)
        y = @camera.worldY(e.gesture.srcEvent.pageY)
        circle.set x: x, y: y

    .on 'dragend', (e) =>
      {pageX, pageY} = e.gesture.srcEvent
      buttonPosition = @$el.offset()
      buttonWidth    = @$el.width()
      buttonHeight   = @$el.height()

      console.log { pageX: pageX, pageY: pageY, buttonPosition: buttonPosition, buttonWidth: buttonWidth, buttonHeight: buttonHeight }
      if pageX >= buttonPosition.left and
         pageX <= (buttonPosition.left + buttonWidth) and
         pageY <= buttonPosition.top and
         pageY >= (buttonPosition.top + buttonHeight)
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
