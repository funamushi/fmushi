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

    @$el
    .text("#{@model.get 'item.name'} ")
    .data('mushi-id', @model.get('id') or @model.cid)
    # .append @$quantity
    @

  