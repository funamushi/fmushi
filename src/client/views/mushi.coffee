mushiStates =
  rest:
    onEnter: (view) ->
      view.sprite.stop()
      view.sprite.textures = view.idleTextues
      view.sprite.gotoAndPlay 0

    update: (view, delta) ->
      

  walking:
    elapsed: 0

    animationSpeed: 0.25
  
    speed: 30
  
    onEnter: (view) ->
      view.sprite.stop()
      view.sprite.textures = view.walkingTextures
      view.sprite.animationSpeed = @animationSpeed
      view.sprite.gotoAndPlay 0
  
    update: (view, delta) ->
      return if view.gripped

      model = view.model
      @elapsed += delta
      if @elapsed > 1
        model.user.addFp 1
        @elapsed = 0
  
      x = model.get('x')
      if model.get('direction') is 'left'
        if x < -10
          model.set direction: 'right'
        else
          model.set x: x - @speed * delta
      else
        if x > 1000
          model.set direction: 'left'
        else
          model.set x: x + @speed * delta
  
  hustle:
    elapsed: 0

    animationSpeed: 0.25
  
    speed: 30
  
    onEnter: (view) ->
      view.sprite.stop()
      view.sprite.textures = view.walkingTextures
      view.sprite.animationSpeed = @animationSpeed
      view.sprite.gotoAndPlay 0
  
    update: (view, delta) ->
      return if view.gripped
  
      model = view.model
      @elapsed += delta
      if @elapsed > 1
        model.user.addFp 10
        @elapsed = 0

      x = model.get('x')
      if model.get('direction') is 'left'
        if x < -10
          model.set direction: 'right'
        else
          model.set x: x - @speed * delta
      else
        if x > 1000
          model.set direction: 'left'
        else
          model.set x: x + @speed * delta

class Fmushi.Views.Mushi extends Fmushi.Views.Base
  initialize: ->
    @listenTo @model, 'change',     @onChanged
    @listenTo @model, 'point:in',   @onPointIn
    @listenTo @model, 'point:out',  @onPointOut
    @listenTo @model, 'focus:in',   @onFocusIn
    @listenTo @model, 'focus:out',  @onFocusOut

    @initSprite()
    @initState()

  initSprite: ->
    @walkingTextures = _.map [
      'fmushi_walk-1-0.png'
      'fmushi_walk-1-1.png'
      'fmushi_walk-2-0.png'
      'fmushi_walk-2-1.png'
    ], (name) -> PIXI.Texture.fromFrame(name)

    @idleTextues = [PIXI.Texture.fromFrame('fmushi_idle.png')]
    @sprite = sprite = new PIXI.MovieClip(@idleTextues)

    attrs = @model.toJSON()
    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5
    sprite.position.x = attrs.x
    sprite.position.y = attrs.y
    sprite.scale.x = 0.5
    sprite.scale.y = 0.5

    sprite.interactive = true
    sprite.buttonMode = true

    # f = new PIXI.ColorMatrixFilter
    # f.matrix = [
    #   3,0,0,0
    #   0,1,0,0
    #   0,0,1,0
    #   0,0,0,1
    # ]
    # sprite.filters = [f]
  
    texture = PIXI.Texture.fromFrame('machi.png')
    text = new PIXI.Sprite texture
    text.anchor.x = 0.5
    text.anchor.y = 0.5
    text.position.x = 0
    text.position.y = 0
    sprite.addChild text

    sprite.mousedown = sprite.touchstart = (e) =>
      e.originalEvent.preventDefault()
      @gripped = true

    sprite.mouseup = sprite.mouseupoutside =
    sprite.touchend = sprite.touchendoutside = (e) =>
      e.originalEvent.preventDefault()
      @gripped = false

    sprite.mousemove = sprite.touchmove = (e) =>
      e.originalEvent.preventDefault()
      if @gripped
        screenPos = e.global
        worldPos  = Fmushi.scene.worldPosFromScreenPos screenPos
        @model.set worldPos

    Fmushi.scene.world.addChild sprite

    @pointShape = shape = Fmushi.two.makeRectangle(
      @model.get('x'), @model.get('y'),
      @sprite.width * 1.1, sprite.height * 1.1
    )
    shape.stroke = '#4CBAEB'
    shape.fill = '#CCE9F9'
    shape.opacity = 1
    shape.visible = false
    Fmushi.scene.shapeWorld.add shape


  initState: ->
    @stateMachine = new Fmushi.StateMachene(@)
    @stateMachine.to 'walking'

    @listenTo Fmushi.Events, 'update', (delta) =>
      @stateMachine.update delta

  onChanged: ->
    changed = @model.changedAttributes()
    if x = changed.x
      @sprite.position.x = x
      @pointShape.translation.x = x if @pointShape

    if y = changed.y
      @sprite.position.y = y
      @pointShape.translation.y = y if @pointShape

    if d = changed.direction
      if d is 'left'
        @sprite.scale.x = 0.5
      else
        @sprite.scale.x = -0.5

    circleId = changed.circleId
    unless _.isUndefined(circleId)
      if circleId?
        circle = @model.circle
        if circle?
          @stateMachine.to circle.get('state')
          if color = circle.color()
            filter = new PIXI.ColorMatrixFilter
            filter.matrix = color.colorMatrix
            @sprite.filters = [filter]
      else
        @sprite.filters = null

  onPointIn: (model) ->
    @pointShape.visible = true

  onPointOut: (model) ->
    @pointShape.visible = false
