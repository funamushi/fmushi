BaseView            = require 'views/base'
BookModalView       = require 'views/book-modal'
MenuOwnMushiButtonView = require 'views/menu-own-mushi-button'
MenuWildMushiButtonView = require 'views/menu-wild-mushi-button'
MenuItemButtonView  = require 'views/menu-item-button'

template = require 'templates/menu'

module.exports = class MenuView extends BaseView
  tagName: 'div'
  className: 'control'
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

    @listenTo stocks,      'add',    @addStock
    @listenTo stocks,      'remove', @removeStock
    @listenTo mushies,     'add',    @addOwnMushi
    @listenTo wildMushies, 'add',    @addWildMushi
    @listenTo mushies,     'remove', @removeMushi
    @listenTo wildMushies, 'remove', @removeMushi

  render: ->
    @$el.html template(owner: @owner.toJSON())

    @$bookButton  = @$('.book-button')
    @$icon        = $(@$('.toggle-button').find('.glyphicon'))
    @$stocks      = @$('.stocks')
    @$mushies     = @$('.mushies')
    @$ownMushies  = @$mushies.children('.own')
    @$wildMushies = @$mushies.children('.wildness')

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
    console.log @subview("mushies/#{mushi.cid}")
    @removeSubview "mushies/#{mushi.cid}"

  addStock: (stock) ->
    itemButtonView = new MenuItemButtonView(model: stock)
    @$stocks.prepend itemButtonView.render().el
    @subview "items/#{stock.get 'item.slug'}", itemButtonView

  removeStock: (stock) ->
    @removeSubview "items/#{stock.get 'item.slug'}"

  onToggleMenu: (e) ->
    e.preventDefault()

    return if @menuLocked
    @menuLocked = true

    if @open
      @$icon.transition {rotate: '180deg'}, 200, 'easeInOutSine', =>
        @$bookButton.hide()
        @$stocks.hide()
        @$mushies.hide()
        @$icon
        .removeClass('glyphicon-minus')
        .addClass('glyphicon-plus')

        @open = false
        @menuLocked = false
    else
      @$icon.transition {rotate: '0deg'}, 200, 'easeInOutSine', =>
        @$bookButton.show()
        @$stocks.show()
        @$mushies.show()
        @$icon
        .removeClass('glyphicon-plus')
        .addClass('glyphicon-minus')

        @open = true
        @menuLocked = false
      
  onOpenBook: (e) ->
    e.preventDefault()
    bookModalView = @subview 'book'
    bookModalView.show()
