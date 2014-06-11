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
      {x, y} = @gesturePosWithCameraOffset(e)
      @model.open x, y

    .on 'drag', (e) =>
      if circle = @model.get('circle')
        position = @gesturePosWithCameraOffset(e)
        circle.set position

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
    {pageX, pageY} = e.gesture.srcEvent
    center = Fmushi.screenCenter()
    offsetX = @camera.get('x') - center.x
    offsetY = @camera.get('y') - center.y
    { x: pageX + offsetX, y: pageY + offsetY }

  dispose: ->
    super
    @hammer?.dispose()
