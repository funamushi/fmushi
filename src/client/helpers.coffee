$messageHeader = $('#message-header')
$indicator     = $('#indicator')

exports.headerMessage = (message, options={}) ->
  if _.isEmpty message
    $messageHeader.children().remove()
    return

  if options.error
    $messageHeader.addClass 'error'
  else
    $messageHeader.removeClass 'error'

  $p = $(document.createElement 'p').text(message)

  close = ->
    height = $messageHeader.height()

    new TWEEN.Tween(top: 0)
    .to({top: -$messageHeader.height()}, 500)
    .easing(TWEEN.Easing.Back.InOut)
    .onUpdate ->
      if @top > 0
        $messageHeader.height(height + @top)
      else
        $messageHeader.css top: @top, height: height
    .onComplete ->
      $p.remove()
    .start()

  $messageHeader.html($p).one 'click', close

  if options.duration?
    setTimeout close, options.duration

exports.showIndicator = ->
  $indicator.show()

exports.hideIndicator = ->
  $indicator.hide()
