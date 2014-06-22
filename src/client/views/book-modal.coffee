BaseView = require 'views/base'
template = require 'templates/book'

module.exports = class BookModalView extends BaseView
  tagName: 'div'
  id: 'book'
  className: 'row'

  initialize: ->
    @listenTo @model.get('mushies'), 'add', @onMushiAdded

  render: ->
    @$el.html template(user: @model.toJSON())
    @

  open: ->
    if @$vexContent?
      vex.close @$vexContent.data().vex.id
    @$vexContent = vex.open
      content: @render().el

  onMushiAdded: (mushi, mushies) ->
    slug = mushi.get('breed.slug')
