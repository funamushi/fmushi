class State
  constructor: (@sprite, @model) ->

  update: (delta) ->

  onEnter: ->

  onExit: ->

class WalkingState extends State
  animationSpeed: 0.25

  speed: 30

  onEnter: -> 
    @sprite.animationSpeed = @animationSpeed

  update: (delta) ->
    model = @model
    x = model.get('x')
    if model.get('direction') == 'left'
      if x < -10
        model.set direction: 'right'
      else
        model.set x: x - @speed * delta
    else
      if x > 1000
        model.set direction: 'left'
      else
        model.set x: x + @speed * delta

class BattleState extends State
  animationSpeed: 0.5

  speed: 30

  onEnter: ->
    @sprite.animationSpeed = @animationSpeed
    @sprite.weapon.visible = true

  onExit: ->
    @sprite.weapon.visible = false

  update: (delta) ->
    model = @model
    x = model.get('x')
    if model.get('direction') == 'left'
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
    @listenTo Fmushi.Events, 'update', (delta) =>
      @currentState.update delta

    @pointShape = shape = Fmushi.two.makeRectangle(
      @model.get('x'), @model.get('y'),
      @model.r * 2.5, @model.r * 1.5
    )
    shape.stroke = '#4CBAEB'
    shape.fill = '#CCE9F9'
    shape.opacity = 1
    shape.visible = false
    Fmushi.app.shapeWorld.add shape

    @initSprite()
    @initWeapon()
    @initState()

  initSprite: ->
    textures = (PIXI.Texture.fromFrame("mushi_walk-#{i}.png") for i in [1..3])
    @sprite = sprite = new PIXI.MovieClip(textures)
    sprite.gotoAndPlay 0

    attrs = @model.attributes
    sprite.anchor.x = 0.4
    sprite.anchor.y = 0.5
    sprite.position.x = attrs.x
    sprite.position.y = attrs.y
    sprite.scale.x = 0.5
    sprite.scale.y = 0.5

    sprite.interactive = true
    sprite.buttonMode = true
  
    texture = PIXI.Texture.fromFrame('default.png')
    text = new PIXI.Sprite texture
    text.anchor.x = 0.5
    text.anchor.y = 0.5
    text.position.x = 0
    text.position.y = -40
    sprite.addChild text

    sprite.mousedown = @sprite.touchstart = (e) =>
      Fmushi.app.dragCancel()
      @gripped = true

    sprite.mouseup = sprite.mouseupoutside = sprite.touchend = sprite.touchendoutside = (e) =>
      @gripped = false

    sprite.mousemove = sprite.touchmove = (e) =>
      if @gripped
        screenPos = e.global
        worldPos  = Fmushi.app.worldPosFromScreenPos screenPos
        @model.set worldPos

    Fmushi.app.world.addChild sprite

  initWeapon: ->
    texture = PIXI.Texture.fromFrame('m4.png')
    @weaponSprite = weaponSprite = new PIXI.Sprite texture
    weaponSprite.anchor.x = 0.5
    weaponSprite.anchor.y = 0
    weaponSprite.position.x = 0
    weaponSprite.position.y = -180
    weaponSprite.visible = false
    @sprite.weapon = weaponSprite
    @sprite.addChild weaponSprite

  initState: ->
    @states =
      walking: new WalkingState(@sprite, @model)
      battle:  new BattleState(@sprite, @model)
    @updateState()

  updateState: (name) ->
    unless name
      name = (if @model.get('circleId') then 'battle' else 'walking')

    if state = @states[name]
      @currentState?.onExit()
      state.onEnter()
      @currentState = state
      @currentStateName = name

  onChanged: ->
    changed = @model.changedAttributes()
    if x = changed.x
      @sprite.position.x = x
      @pointShape.translation.x = x if @pointShape

    if y = changed.y
      @sprite.position.y = y
      @pointShape.translation.y = y if @pointShape

    if d = changed.direction
      if d == 'left'
        @sprite.scale.x = 0.5
      else
        @sprite.scale.x = -0.5
  
    unless _.isUndefined(changed.circleId)
      @updateState() unless @currentStateName is 'gripped'

  onPointIn: (model) ->
    @pointShape.visible = true

  onPointOut: (model) ->
    @pointShape.visible = false
