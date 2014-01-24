class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  events:
    'click          #user-name-ok': 'showPassword'
    'click          #user-password-cancel': 'showUsername'
    'click          #user-password-ok': 'onSubmit'
    'propertychange #user-name': 'onInput'
    'input          #user-name': 'onInput'
    'change         #user-name': 'onInput'
    'propertychange #user-password': 'OnInput'
    'input          #user-password': 'OnInput'
    'change         #user-password': 'OnInput'

  initialize: (options) ->
    @user = new Fmushi.Models.User
      password: 'めちゃめちゃがんばって生きているっちゅうねん'

    center = Fmushi.screenCenter()

    mushiTextures = (PIXI.Texture.fromFrame("mushi_walk-#{i}.png") for i in [1..3])
    @mushi = mushi = new PIXI.MovieClip mushiTextures
    mushi.anchor.x = 0.5
    mushi.anchor.y = 0.5
    mushi.position.x = center.x
    mushi.position.y = center.y * 0.7
    mushi.animationSpeed = 0.6
    mushi.visible = false
    mushi.gotoAndPlay 0
    @world.addChild mushi

    iwaTexture = PIXI.Texture.fromFrame('iwa2.png')
    @iwa = iwa = new PIXI.Sprite iwaTexture

    iwa.anchor.x = 0.5
    iwa.anchor.y = 0.5
    iwa.position.x = mushi.position.x
    iwa.position.y = mushi.position.y
    iwa.pivot.x = 0.9
    iwa.pivot.y = 0
    iwa.interactive = true
    iwa.buttonMode = true

    iwaUp = new TWEEN.Tween(rotation: iwa.rotation)
    .to({ rotation: 0.2 }, 100)
    .onUpdate ->
      iwa.rotation = @rotation

    iwaDown = new TWEEN.Tween(rotation: iwa.rotation)
    .to({ rotation: 0 })
    .onUpdate ->
      iwa.rotation = @rotation

    iwaUp.chain(iwaDown).delay(1000).repeat(10).start()

    iwa.click = iwa.tap = (e) =>
      iwaUp.stop()
      @startMushi()

    @world.addChild iwa


    @world.addChild iwa

    @render()

    if options.step is 'username'
      @startMushi @showUsername
    else if options.step is 'password'
      @startMushi @showPassword

    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.html JST['register-form']()
    @$('#password').val @user.get('password')
    @

  startMushi: (callback) ->
    @iwa.visible = false

    mushi = @mushi
    mushi.visible = true

    fromX = mushi.position.x
    toX   = fromX - 100

    callback ?= @showUsername

    dash = new TWEEN.Tween(x: fromX)
      .to({ x: toX })
      .onUpdate ->
        mushi.position.x = @x
    back = new TWEEN.Tween(x: toX)
      .to({ x: fromX })
      .onUpdate ->
        mushi.position.x = @x
      .onComplete =>
        callback.call @

    dash.chain(back).start()
    
  showUsername: (e) ->
    e?.preventDefault()

    @$('#password-dialog').popover('hide')

    setTimeout ( =>
      @$('.username').addClass('in')
      @$('.password').removeClass('in')
      @$('#username-dialog').popover('show')
      ), 350
    
  showPassword: (e) ->
    e?.preventDefault()
    return unless @user.isValid()

    @$('#username-dialog').popover('hide')

    setTimeout ( =>
      @$('.username').removeClass('in')
      @$('.password').addClass('in')
      @$('#password-dialog').popover('show')
      ), 350

  onInput: (e) ->
    e.preventDefault()

    $input = $(e.target)
    val  = $input.val()
    attr = $input.data 'attr'
    @user.set attr, val, validate: true
  
    errors = @user.validationError
    if _.any(errors, (error) -> error.attr is attr)
      $input.removeClass('valid').addClass('invalid')
    else
      $input.removeClass('invalid').addClass('valid')

  onSubmit: (e) ->
    e.preventDefault()

    return unless @user.isValid()

    if confirm("この内容で登録します。よろしいですか？\n\nユーザ名:「#{@user.get 'name'}」\n好きな言葉:「#{@user.get 'password'}」")
      Fmushi.viewer = @user
      Fmushi.viewer.register().then (data) ->
        Backbone.history.navigate '/', trigger: true
