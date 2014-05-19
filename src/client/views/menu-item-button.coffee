BaseView = require 'views/base'

template = require 'templates/item-popover'

module.exports = class MenuItemButtonView extends BaseView
  tagName: 'button'
  className: 'btn btn-inverse'
  attributes:
    type: 'button'

  render: ->
    console.log @model.toJSON()


    @$quantity = $(document.createElement 'span')
    .addClass('quantity')
    .text @model.get('quantity')

    $(@$el)
    .html("#{@model.get 'item.name'}" +
          "x<span class=\"quantity\"> #{@model.get 'quantity'} </span>")
    .clickover
      html:      true
      placement: 'bottom'
      trigger:   'click'
      content:   template(belonging: @model.toJSON())
      container: @$el
    @

  