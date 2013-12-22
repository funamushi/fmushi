class Fmushi.Scenes.Base extends Fmushi.Views.Base
  fps: 24
  
  start: (options={}) ->
    $window = $(window)
    w = $window.width()
    h = $window.height()

    Two.Resolution = 16;

    Fmushi.two = two = new Two(fullscreen: true).appendTo(document.body)
    Fmushi.stage = stage = new PIXI.Stage 0x000000, true
    Fmushi.stage.interactive = true
    Fmushi.stage.interactionManager.preventDefault = false

    renderer = PIXI.autoDetectRenderer w, h, null, true
    renderer.view.id = 'stage'
    renderer.view.style.position = "absolute"
    renderer.view.style.top  = "0"
    renderer.view.style.left = "0"
    document.body.appendChild renderer.view
    Fmushi.renderer = renderer

    @onResize()
    $(window).resize _.bind(@onResize, @)

    Fmushi.items = items = new Fmushi.Collections.Items
    Fmushi.ranks = ranks = new Fmushi.Collections.Ranks

    $.when(
      items.fetch(),
      ranks.fetch()
    ).done => @onStarted()

    interval = 1 / @fps

    getTime = @getTime
    @startTime = lastTime = getTime()
    @frames = 0

    Events = Fmushi.Events
    elapsed = 0
    mainLoop = => 
      currentTime = getTime()
      delta = currentTime - lastTime
      elapsed += delta

      requestAnimFrame mainLoop
      if elapsed >= interval
        TWEEN.update()
        two.update()
        renderer.render stage
        Events.trigger 'update', elapsed
        elapsed = 0

      lastTime = getTime()

    requestAnimFrame mainLoop

  getTime: -> 
    now = window.performance && (
      performance.now || 
      performance.mozNow || 
      performance.msNow || 
      performance.oNow || 
      performance.webkitNow );

    msec = (now && now.call(performance)) || (new Date().getTime())
    msec * 0.001

  onResize: ->
    $window = $(window)
    w = $window.width()
    h = $window.height()

    Fmushi.renderer.resize(w, h)

    @screenSize = { w: w, h: h}
    Fmushi.Events.trigger 'resize', @screenSize

  screenCenter: ->
    { x: @screenSize.w / 2, y: @screenSize.h / 2 }
