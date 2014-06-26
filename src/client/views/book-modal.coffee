BaseView = require 'views/base'
indexTemplate = require 'templates/book-index'
pageTemplate  = require 'templates/book-page'

module.exports = class BookModalView extends BaseView
  tagName: 'div'
  id: 'book'
  className: 'row'

  events:
    'click .entry': 'onEntryClicked'
    'click .back':  'onBack'

  initialize: ->
    @listenTo @model.get('mushies'), 'add', @onMushiAdded

  open: (html) ->
    html ?= indexTemplate(user: @model.toJSON())
    @close()
    @$vexContent = vex.open
      content: @$el.html(html)
    .on 'vexOpen', ->
      $(document.body).addClass 'vex-open'
    .on 'vexClose', ->
      $(document.body).removeClass 'vex-open'

  close: ->
    vex.close @$vexContent?.data('vex')?.id

  onMushiAdded: (mushi, mushies) ->
    slug = mushi.get('breed.slug')

  onEntryClicked: (e) ->
    e.preventDefault()

    $wrapper = $(e.target).closest('.entry')
    number = $wrapper.data('number')
    page = @model.get('bookPages').findWhere(number: number)
    @open(pageTemplate page: page.toJSON())if page?

  onBack: (e) ->
    e.preventDefault()
    @open()