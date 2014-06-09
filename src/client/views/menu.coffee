BaseView            = require 'views/base'
BookModalView       = require 'views/book-modal'
MenuOwnMushiButtonView = require 'views/menu-own-mushi-button'
MenuWildMushiButtonView = require 'views/menu-wild-mushi-button'
MenuItemButtonView  = require 'views/menu-item-button'

template = require 'templates/menu'

module.exports = class MenuView extends BaseView
  tagName: 'div'
  attributes:
    id: 'menu'

  events:
    'click .toggle-button': 'onToggleMenu'
    'click     .mushies .btn': 'onFocus'
    'click .stocks .btn': 'onClickStock'
    'click .book-button': 'onOpenBook'

  initialize: (options) ->
    @owner       = owner       = options.owner
    @wildMushies = wildMushies = options.wildMushies

    bookModalView = new BookModalView
    @subview 'book', bookModalView

    mushies = owner.get('mushies')
    stocks  = owner.get('stocks')

    @listenTo stocks,      'add',       @addStock
    @listenTo stocks,      'remove',    @removeStock
    @listenTo mushies,     'add',       @addOwnMushi
    @listenTo wildMushies, 'add',       @addWildMushi
    @listenTo mushies,     'remove',    @removeMushi
    @listenTo wildMushies, 'remove',    @removeMushi
    @listenTo mushies,     'focus:in',  @focusOut
    @listenTo wildMushies, 'focus:in',  @focusOut
    @listenTo mushies,     'focus:out', @focusIn
    @listenTo wildMushies, 'focus:out', @focusIn

  render: ->
    @$el.html template(owner: @owner.toJSON())

    @$toggleButton = $(@$('.toggle-button'))
    @$toggleIcon         = $(@$toggleButton.find('.glyphicon'))
    @$command      = $(@$('.command'))
    @$bookButton   = @$command.children('.book-button')
    @$stocks       = @$command.children('.stocks')
    @$mushies      = $(@$('.mushies'))
    @$ownMushies   = @$mushies.children('.own-mushies')
    @$wildMushies  = @$mushies.children('.wild-mushies')

    @open = true

    owner = @owner
    owner.get('stocks').each (stock) =>
      @addStock stock

    owner.get('mushies').each (mushi) =>
      @addOwnMushi mushi

    @wildMushies.each (mushi) =>
      @addWildMushi mushi
    @

  addOwnMushi: (mushi) ->
    mushiButtonView = new MenuOwnMushiButtonView(model: mushi)
    @$ownMushies.append mushiButtonView.render().el
    @subview "mushies/#{mushi.cid}", mushiButtonView

  addWildMushi: (mushi) ->
    mushiButtonView = new MenuWildMushiButtonView(model: mushi)
    @$wildMushies.append mushiButtonView.render().el
    @subview "mushies/#{mushi.cid}", mushiButtonView

  removeMushi: (mushi) ->
    @removeSubview "mushies/#{mushi.cid}"

  addStock: (stock) ->
    itemButtonView = new MenuItemButtonView(model: stock)
    @$stocks.prepend itemButtonView.render().el
    @subview "items/#{stock.get 'item.slug'}", itemButtonView

  removeStock: (stock) ->
    @removeSubview "items/#{stock.get 'item.slug'}"

  focusOut: ->
    @$toggleButton.transition
      y:        @$toggleButton.height() * 1.5
      duration: 200
      easing:   'snap'

    @$command.transition
      y:        @$command.height() * 1.5
      duration: 200
      easing:   'snap'

    @$mushies.transition
      x:        @$mushies.width() * 0.9
      duration: 200
      easing:   'snap'

  focusIn: ->
    @$toggleButton.transition
      y:        0
      duration: 200
      easing:   'snap'

    @$command.transition
      y:        0
      duration: 200
      easing:   'snap'

    @$mushies.transition
      x:        0
      duration: 200
      easing:   'snap'

  onToggleMenu: (e) ->
    e.preventDefault()

    return if @menuLocked
    @menuLocked = true

    if @open
      @$toggleIcon.transition {rotate: '180deg'}, 200, 'easeInOutSine', =>
        @$command.hide()
        @$mushies.hide()
        @$toggleIcon
        .removeClass('glyphicon-minus')
        .addClass('glyphicon-plus')

        @open = false
        @menuLocked = false
    else
      @$toggleIcon.transition {rotate: '0deg'}, 200, 'easeInOutSine', =>
        @$command.show()
        @$mushies.show()
        @$toggleIcon
        .removeClass('glyphicon-plus')
        .addClass('glyphicon-minus')

        @open = true
        @menuLocked = false
      
  onOpenBook: (e) ->
    e.preventDefault()
    bookModalView = @subview 'book'
    bookModalView.show()
