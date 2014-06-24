BaseView = require 'views/base'
indexTemplate = require 'templates/book-index'
pageTemplate  = require 'templates/book-page'

module.exports = class BookModalView extends BaseView
  tagName: 'div'
  id: 'book'
  className: 'row'

  events:
    'click .entry': 'onEntryOpen'
    'click .back':  'onBack'

  initialize: ->
    @listenTo @model.get('mushies'), 'add', @onMushiAdded

  open: ->
    @close()
    @$vexContent = vex.open
      content: @$el.html(indexTemplate user: @model.toJSON())

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
      @close()
      @$vexContent = vex.open
        content: @$el.html(pageTemplate page: page.toJSON())

  onBack: (e) ->
    e.preventDefault()