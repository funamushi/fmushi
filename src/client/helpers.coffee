elements = require 'elements'

$content   = $('#content')
$message   = $('#message-tape')
$indicator = $('#indicator')

exports.messageTape = (message, options={}) ->
  if _.isEmpty message
    $message.children().remove()
    return

  if options.error
    $message.addClass 'error'
  else
    $message.removeClass 'error'

  $p = $(document.createElement 'p').text(message)

  close = ->
    $message.transition
      opacity:  0
      scale:    1.125
      duration: 250
      easing:   'easeOutCubic'
    , ->
      $p.remove()
      $message.attr 'style', ''

  $message.html($p).one 'click', close
  height = $message.height()
  $content.css marginBottom: "-#{height}px"

  setTimeout close, (options.duration or 2000)

exports.showIndicator = ->
  $indicator.show()

exports.hideIndicator = ->
  $indicator.hide()

Handlebars.registerHelper 'elementName', (element) ->
  name = elements.name(element)
  html = "<span class=\"element-#{element} circle\">#{name}</span>"
  new Handlebars.SafeString html

Handlebars.registerHelper 'elementNextName', (element) ->
  nextElement = elements.next(element)
  Handlebars.helpers.elementName nextElement

Handlebars.registerHelper 'elementPrevName', (element) ->
  prevElement = elements.prev(element)
  Handlebars.helpers.elementName prevElement

Handlebars.registerHelper 'elementInverseName', (element) ->
  inverseElement = elements.inverse(element)
  Handlebars.helpers.elementName inverseElement

Handlebars.registerHelper 'circle', (element) ->
  html = "<span class=\"element-icon-#{element}\">&#x2B24;</span>"
  new Handlebars.SafeString html
  
Handlebars.registerHelper 'times', (n, block) ->
  accum = ''
  for i in [0...n]
    accum += block.fn(@)
  accum