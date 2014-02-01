class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  events:
    'click          .next': 'onNext'
    'click          .prev': 'onPrev'
    'click          .register': 'onRegister'
    'propertychange #user-name': 'onInput'
    'input          #user-name': 'onInput'
    'change         #user-name': 'onInput'
    'propertychange #user-password': 'onInput'
    'input          #user-password': 'onInput'
    'change         #user-password': 'onInput'

  initialize: (options) ->
    @user = new Fmushi.Models.User
      password: 'めちゃめちゃがんばって生きているっちゅうねん'

    @listenTo @user, 'change', @onUpdate
    @listenTo @user, 'invalid', ->
      console.log arguments

    @initSprite()
    @render()

    setTimeout ( => @trigger 'ready'), 0

  initSprite: ->
    mushiTextures = (PIXI.Texture.fromFrame("mushi_walk-#{i}.png") for i in [1..3])
    @mushi = mushi = new PIXI.MovieClip mushiTextures
    mushi.anchor.x = 0.5
    mushi.anchor.y = 0.5
    mushi.animationSpeed = 0.6
    mushi.visible = false
    mushi.gotoAndPlay 0
    @world.addChild mushi

    iwaTexture = PIXI.Texture.fromFrame('iwa2.png')
    @iwa = iwa = new PIXI.Sprite iwaTexture

    center = Fmushi.screenCenter()
    iwa.anchor.x = 0.5
    iwa.anchor.y = 0.5
    iwa.position.x = center.x
    iwa.position.y = center.y * 0.7
    iwa.interactive = true
    iwa.buttonMode = true
    iwa.click = iwa.tap = (e) =>
      @startMushi(iwa.position.x, iwa.position.y)

    @world.addChild iwa

    @listenTo Fmushi.Events, 'resize', (w, h) ->
      mushi.position.x = w * 0.5
      mushi.position.y = (h * 0.5) * 0.7

      iwa.position.x = mushi.position.x
      iwa.position.y = mushi.position.y

  render: ->
    @$el.html JST['register-form'] user: @user.toJSON()
    @$('.slide').css x: '100%'
    @

  startMushi: (x, y) ->
    @iwa.visible = false

    mushi = @mushi
    mushi.position.x = x
    mushi.position.y = y
    mushi.visible = true

    fromX = mushi.position.x
    toX   = fromX - 100

    dash = new TWEEN.Tween(x: fromX)
      .to({ x: toX })
      .onUpdate ->
        mushi.position.x = @x
    back = new TWEEN.Tween(x: toX)
      .to({ x: fromX })
      .onUpdate ->
        mushi.position.x = @x
      .onComplete =>
        @onNext()

    dash.chain(back).start()

  onRegister: ->
    register = @user.register()
    console.log register
    console.log @user.isValid()
    console.log @user.validationError
    if register
      $('#register').button('loading')
      register
      .then (data) =>
        Fmushi.viewer = @user
        Backbone.history.navigate '/', trigger: true
      .always ->
        $('#register').button('reset')
    
  onInput: (e) ->
    e.preventDefault()

    $input = $(e.target)
    val  = $input.val()
    attr = $input.data 'attr'
    @user.set attr, val

  onUpdate: (user)->
    user.isValid()

    @$('input').each (i, input) =>
      $input = $(input)
      attr = $input.data('attr')
    
      if _.any(user.validationError, (error) -> error.attr is attr)
        $input.removeClass('valid').addClass('invalid')
      else
        $input.removeClass('invalid').addClass('valid')

  onNext: (e) ->
    e?.preventDefault()

    $current = @$('.slide.current')
    $next =
      if $current.length
        $current.next('.slide')
      else
        @$('.slide:first')

    $current.removeClass('current').transition x: '-100%'
    $next.addClass('current').transition x: '0%'

    @dialog()

  onPrev: (e) ->
    e?.preventDefault()

    $current = @$('.slide.current')
    $prev =
      if $current.length
        $current.prev('.slide')
      else
        @$('.slide:first')
    $current.removeClass('current').transition x: '0%'
    $prev.addClass('current').transition x: '100%'

    @dialog()

  dialog: ->
    content = @$('.slide.current').data('kotoba')
    if content
      $dialog = $('#dialog')
      $dialog.popover 'destroy'
      $dialog.data 'content', content
      $dialog.popover 'show'
