Fmushi = require 'fmushi'
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
    'click .toggle-button': 'toggle'
    'click .mushies .btn': 'onFocus'
    'click .stocks .btn': 'onClickStock'
    'click .book': 'onOpenBook'

  initialize: (options) ->
    @owner       = owner       = options.owner
    @wildMushies = wildMushies = options.wildMushies

    bookModalView = new BookModalView(model: owner)
    @subview 'book', bookModalView

    mushies = owner.get('mushies')
    stocks  = owner.get('stocks')

    @listenTo stocks,      'add',       @addStock
    @listenTo stocks,      'remove',    @removeStock
    @listenTo mushies,     'add',       @addOwnMushi
    @listenTo wildMushies, 'add',       @addWildMushi
    @listenTo mushies,     'remove',    @removeOwnMushi
    @listenTo wildMushies, 'remove',    @removeWildMushi
    @listenTo mushies,     'focus:in',  @focusOut
    @listenTo wildMushies, 'focus:in',  @focusOut
    @listenTo mushies,     'focus:out', @focusIn
    @listenTo wildMushies, 'focus:out', @focusIn

  render: ->
    @$el.html template(owner: @owner.toJSON())

    @$toggleButton = $(@$('.toggle-button'))
    @$toggleIcon   = $(@$toggleButton.find('.glyphicon'))
    @$command      = $(@$('.command'))
    @$bookButton   = @$command.children('.book-button')
    @$stocks       = @$command.children('.stocks')
    @$mushies      = $(@$('.mushies'))
    @$ownMushies   = @$mushies.children('.own-mushies')
    @$wildMushies  = @$mushies.children('.wild-mushies')

    owner = @owner
    owner.get('stocks').each (stock) =>
      @addStock stock

    owner.get('mushies').each (mushi) =>
      @addOwnMushi mushi

    @wildMushies.each (mushi) =>
      @addWildMushi mushi
    @

  addOwnMushi: (mushi) ->
    key = "mushies/#{mushi.cid}/own"
    mushiButtonView = new MenuOwnMushiButtonView(model: mushi)
    @$ownMushies.append mushiButtonView.render().el
    @subview key, mushiButtonView

  addWildMushi: (mushi) ->
    key = "mushies/#{mushi.cid}/wild"

    mushiButtonView = new MenuWildMushiButtonView(model: mushi)
    @$wildMushies.append mushiButtonView.render().el

    windowWidth = Fmushi.windowSize.w
    $(mushiButtonView.$el)
    .transition(x: -windowWidth, duration: 0)
    .transition(x: 0, duration: 200, easing: 'easeInOutExpo')
    @subview key, mushiButtonView

  removeOwnMushi: (mushi) ->
    key = "mushies/#{mushi.cid}/own"

    windowWidth = Fmushi.windowSize.w
    view = @subview key
    $(view.$el).transition x: -windowWidth, easing: 'easeInOutExpo', =>
      @removeSubview key

  removeWildMushi: (mushi) ->
    key = "mushies/#{mushi.cid}/wild"

    windowWidth = Fmushi.windowSize.w
    view = @subview key
    $(view.$el).transition x: -windowWidth, easing: 'easeInOutExpo', =>
      @removeSubview key

  addStock: (stock) ->
    camera = @owner.get('camera')
    itemButtonView = new MenuItemButtonView(model: stock, camera: camera)
    @$stocks.prepend itemButtonView.render().el
    @subview "items/#{stock.get 'item.slug'}", itemButtonView

  removeStock: (stock) ->
    @removeSubview "items/#{stock.get 'item.slug'}"

  focusOut: (options={}) ->
    return if @focusOutNow
    @focusOutNow = true

    promises = []

    duration = (options.duration or 200)
    if options.withOutToggleButton
      @$toggleButton
      .transition
        y:        @$toggleButton.height() * 1.5
        duration: duration
        easing:   'snap'

    @$command.transition
      y:        @$command.height() * 1.5
      duration: duration
      easing:   'snap'

    @$mushies.transition
      x:        260
      duration: 200
      easing:   'snap'

  focusIn: (options={}) ->
    @focusOutNow = false

    duration = (options.duration or 200)
    if options.withOutToggleButton
      @$toggleButton.transition
        y:        0
        duration: duration
        easing:   'snap'

    @$command.transition
      y:        0
      duration: duration
      easing:   'snap'

    @$mushies.transition
      x:        0
      duration: duration
      easing:   'snap'

  close: (options={}) ->
    return if @closed

    @closed = true
    @$toggleIcon.transition
      rotate: '180deg'
      easing: 'easeInOutSine'
      duration: (options.duration or 200)
    , =>
      @focusOut(options)
      @$toggleIcon
      .removeClass('glyphicon-minus-sign')
      .addClass('glyphicon-plus-sign')

  open: (options={}) ->
    return unless @closed

    @closed = false
    @$toggleIcon.transition
      rotate: '0deg'
      easing: 'easeInOutSine'
      duration: (options.duration or 200)
    , =>
      @focusIn(options)
      @$toggleIcon
      .removeClass('glyphicon-plus-sign')
      .addClass('glyphicon-minus-sign')

  toggle: (e) ->
    e?.preventDefault()

    if @closed then @open() else @close()
      
  onOpenBook: (e) ->
    e.preventDefault()

    @subview('book').openIndex()
