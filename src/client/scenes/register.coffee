class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  events: ->
    'click #username-ok': 'showPassword'
    'click #password-cancel': 'showUsername'
    'click #password-ok': ''

  initialize: ->
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
    iwa = new PIXI.Sprite iwaTexture

    iwa.anchor.x = 0.5
    iwa.anchor.y = 0.5
    iwa.position.x = mushi.position.x
    iwa.position.y = mushi.position.y
    iwa.interactive = true
    iwa.buttonMode = true
    iwa.click = iwa.tap = (e) =>
      iwa.visible = false
      @startMushi()

    @world.addChild iwa

    @render()
    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.html JST['register-form']()

  startMushi: ->
    mushi = @mushi
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
    
  showUsername: ->
    @$('#username-dialog').popover('show')
    @$('#password-dialog').popover('hide')

    setTimeout ( =>
      @$('.username').addClass('in')
      @$('.password').removeClass('in')
      ), 350
    
  showPassword: ->
    @$('#username-dialog').popover('hide')
    @$('#password-dialog').popover('show')

    setTimeout ( =>
      @$('.username').removeClass('in')
      @$('.password').addClass('in')
      ), 350
