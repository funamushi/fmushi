BaseView = require 'views/base'
Circle = require 'models/circle'

buttonTemplate  = require 'templates/menu-item-button'
popoverTemplate = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'item'

  events:
    'click': 'onStartDrag'

  render: ->
    $(@$el)
    .addClass("element-icon-#{@model.get 'item.element'}")
    .html(buttonTemplate belonging: @model.toJSON())
    @

  onStartDrag: (e) ->
    e.preventDefault()

    circle = new Circle(item: @model.get('item'))
