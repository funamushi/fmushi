BaseView = require 'views/base'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'btn btn-inverse'
  attributes:
    type: 'button'

  render: ->
    @$quantity = $(document.createElement 'span')
    .addClass('quantity')
    .text @model.get('quantity')

    $(@$el)
    .html("#{@model.get 'item.name'}" +
          "x<span class=\"quantity\"> #{@model.get 'quantity'} </span>")
    .popover
      html:      true
      placement: 'bottom'
      trigger:   'click'
      content:   'unko'
      container: @$el
    @

  