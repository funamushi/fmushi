BaseView = require 'views/base'
Circle = require 'models/circle'

template = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'item'

  events:
    'click': 'onStartDrag'

  render: ->
    $icon = $(document.createElement 'span')
    .addClass("badge element-#{@model.get 'item.element'}")
    .text(@model.get 'quantity')
    
    $(@$el)
    .addClass("element-icon-#{@model.get 'item.element'}")
    .html("<span class=\"badge element-#{@model.get 'item.element'}\">#{@model.get 'quantity'}</span>#{@model.get 'item.name'}")
    @

  onStartDrag: (e) ->
    e.preventDefault()

    circle = new Circle(item: @model.get('item'))
