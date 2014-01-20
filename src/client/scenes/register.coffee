class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  events: ->
    'click #username-ok': 'showPassword'
    'click #password-cancel': 'showUsername'
    'click #password-ok': ''

  initialize: (options) ->
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
    iwa.interactive = true
    iwa.buttonMode = true
    iwa.click = iwa.tap = (e) =>
      @startMushi()

    @world.addChild iwa

    @render()

    if options.step is 'username'
      @startMushi @showUsername
    else if options.step is 'password'
      @startMushi @showPassword

    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.html JST['register-form']()

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

    @$('#username-dialog').popover('show')
    @$('#password-dialog').popover('hide')

    setTimeout ( =>
      @$('.username').addClass('in')
      @$('.password').removeClass('in')

      Backbone.history.navigate '/register/username'
      ), 350
    
  showPassword: (e) ->
    e?.preventDefault()

    @$('#username-dialog').popover('hide')
    @$('#password-dialog').popover('show')

    setTimeout ( =>
      @$('.username').removeClass('in')
      @$('.password').addClass('in')
      Backbone.history.navigate '/register/password'
      ), 350
