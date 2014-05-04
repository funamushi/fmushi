Fmushi       = require 'fmushi'
BaseView     = require 'views/base'
StateMachine = require 'state-machine'

class MushiStateMachine extends StateMachine
  states:
    wild:
      animationSpeed: 0.25
      speed: 35

      onEnter: (view) ->
        view.sprite.stop()

      update: (view, delta) ->
        return if view.gripped

    rest:
      onEnter: (view) ->
        view.animate 'idle'

      update: (view, delta) ->
        

    walking:
      animationSpeed: 0.25
      speed: 30
    
      onEnter: (view) ->
        view.animate 'walking', speed: @animationSpeed
    
      update: (view, delta) ->
        return if view.gripped

        model = view.model
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
      animationSpeed: 0.25
      speed: 30
    
      onEnter: (view) ->
        view.animate 'walking', spped: @animationSpeed
    
      update: (view, delta) ->
        return if view.gripped
    
        model = view.model
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

module.exports = class MushiView extends BaseView
  initialize: ->
    @listenTo @model, 'change',     @onChanged
    @listenTo @model, 'point:in',   @onPointIn
    @listenTo @model, 'point:out',  @onPointOut
    @listenTo @model, 'focus:in',   @onFocusIn
    @listenTo @model, 'focus:out',  @onFocusOut

    @initSprite()
    @initState()

  initSprite: ->
    @textures = {}

    @textures.walking = _.map [
      'fmushi_walk-1-0.png'
      'fmushi_walk-1-1.png'
      'fmushi_walk-2-0.png'
      'fmushi_walk-2-1.png'
    ], (name) -> PIXI.Texture.fromFrame(name)

    @textures.idle = idleTextures = [PIXI.Texture.fromFrame('fmushi_idle.png')]
    @sprite = sprite = new PIXI.MovieClip(idleTextures)

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
  
    # texture = PIXI.Texture.fromFrame('machi.png')
    # text = new PIXI.Sprite texture
    # text.anchor.x = 0.5
    # text.anchor.y = 0.5
    # text.position.x = 0
    # text.position.y = 0
    # sprite.addChild text

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

    @shape = shape = Fmushi.two.makeRectangle(
      @model.get('x'), @model.get('y'),
      @sprite.width * 1.1, sprite.height * 1.1
    )
    shape.stroke = '#4CBAEB'
    shape.fill = '#CCE9F9'
    shape.opacity = 1
    shape.visible = false

  initState: ->
    @stateMachine = new MushiStateMachine(@)
    @stateMachine.to 'walking'

    @listenTo Fmushi.events, 'update', (delta) =>
      @stateMachine.update delta

  animate: (name, options={}) ->
    @sprite.stop()
    @sprite.textures = @textures[name]

    if speed = options.speed
      @sprite.animationSpeed = speed
    @sprite.gotoAndPlay 0

  onChanged: ->
    changed = @model.changedAttributes()
    if x = changed.x
      @sprite.position.x = x
      @shape.translation.x = x if @shape

    if y = changed.y
      @sprite.position.y = y
      @shape.translation.y = y if @shape

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
    @shape.visible = true

  onPointOut: (model) ->
    @shape.visible = false
