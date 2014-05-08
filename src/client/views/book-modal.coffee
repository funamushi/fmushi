BaseView = require 'views/base'
template = require 'templates/book'

module.exports = class BookModalView extends BaseView
  className: 'modal fade'
  attributes:
    id: 'book-modal'
    roll: 'dialog'
    ariaLabelledby: 'book-modal-title'
    ariaHidden: 'true'

  events:
    'click .save': 'onSave'

  initialize: ->
    @$el = $(@$el).modal(show: false)

  render: ->
    @$el.html template()

  show: ->
    @render()
    @$el.modal 'show'

  onSave: (e) ->
    e.preventDefault()
    