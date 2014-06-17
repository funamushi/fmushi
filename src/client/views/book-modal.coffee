BaseView = require 'views/base'
template = require 'templates/book'

module.exports = class BookModalView extends BaseView
  tagName: 'div'
  id: 'book-inner'
  className: 'row'

  render: ->
    @$el.html template(user: @model.toJSON())
    @

  open: ->
    vex.open
      content: @render().el
