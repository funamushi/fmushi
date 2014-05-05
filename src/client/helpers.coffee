$content   = $('#content')
$message   = $('#message-footer')
$indicator = $('#indicator')

exports.footerMessage = (message, options={}) ->
  if _.isEmpty message
    $message.children().remove()
    return

  if options.error
    $message.addClass 'error'
  else
    $message.removeClass 'error'

  $p = $(document.createElement 'p').text(message)

  close = ->
    $message.transition {rotateX: '90deg'}, ->
      $p.remove()

  $message.html($p).one 'click', close
  height = $message.height()
  $content.css marginBottom: "-#{height}px"

  if options.duration?
    setTimeout close, options.duration

exports.showIndicator = ->
  $indicator.show()

exports.hideIndicator = ->
  $indicator.hide()
