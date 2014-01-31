class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  events:
    'click          #user-name-ok': 'showPassword'
    'click          #user-password-cancel': 'showUsername'
    'click          #user-password-ok': 'register'
    'propertychange #user-name': 'input'
    'input          #user-name': 'input'
    'change         #user-name': 'input'
    'propertychange #user-password': 'input'
    'input          #user-password': 'input'
    'change         #user-password': 'input'

  initialize: (options) ->
    @user = new Fmushi.Models.User
      password: 'めちゃめちゃがんばって生きているっちゅうねん'

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

    @render()

    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.html JST['register-form']()
    @$('#password').val @user.get('password')
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
        @showUsername()

    dash.chain(back).start()
    
  showUsername: (e) ->
    e?.preventDefault()

    @$('#password-dialog').popover('hide')

    setTimeout =>
      @$('.username').addClass('in')
      @$('.password').removeClass('in')
      @$('#username-dialog').popover('show')
    , 350
    
  showPassword: (e) ->
    e?.preventDefault()
    return unless @user.isValid()

    @$('#username-dialog').popover('hide')

    setTimeout ( =>
      @$('.username').removeClass('in')
      @$('.password').addClass('in')
      @$('#password-dialog').popover('show')
      ), 350

  input: (e) ->
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

  register: (e) ->
    e.preventDefault()

    return unless @user.isValid()

    if confirm("この内容で登録します。よろしいですか？\n\nユーザ名:「#{@user.get 'name'}」\n好きな言葉:「#{@user.get 'password'}」")
      Fmushi.viewer = @user
      Fmushi.viewer.register().then (data) ->
        Backbone.history.navigate '/', trigger: true
