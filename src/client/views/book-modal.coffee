BaseView = require 'views/base'
indexTemplate = require 'templates/book-index'
pageTemplate  = require 'templates/book-page'

module.exports = class BookModalView extends BaseView
  tagName: 'div'
  id: 'book'
  className: 'row'

  events:
    'click .open-entry': 'onEntryClicked'
    'click .back':  'onBack'

  initialize: ->
    @listenTo @model.get('mushies'), 'add', @onMushiAdded

  openIndex: ->
    @open(indexTemplate user: @model.toJSON())

  openPage: (page) ->
    @open(pageTemplate page: page.toJSON())
    page.set new: false

  close: ->
    vex.close @$vexContent?.data('vex')?.id

  onMushiAdded: (mushi, mushies) ->
    slug = mushi.get('breed.slug')

  onEntryClicked: (e) ->
    e.preventDefault()

    $wrapper = $(e.target).closest('.entry')
    number = $wrapper.data('number')
    page = @model.get('bookPages').findWhere(number: number)
    if page?
      @openPage(page)

  onBack: (e) ->
    e.preventDefault()
    @openIndex()

  open: (html) ->
    @close()
    @$vexContent = vex.open
      content: @$el.html(html)
    