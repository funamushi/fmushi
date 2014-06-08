Fmushi   = require 'fmushi'
BaseView = require 'views/base'
MushiStateMachine = require 'models/mushi-state-machine'

module.exports = class MushiView extends BaseView
  animationSpeed:
    wild:    0.25
    walking: 0.25
    hustle:  0.25

  initialize: (options) ->
    @initSprite()

    model  = @model
    sprite = @sprite
    shape  = @shape

    @stateMachine = stateMachine = new MushiStateMachine(model)
    @listenTo Fmushi.events, 'update', (delta) ->
      stateMachine.update delta

    @listenTo model, 'change:x', (m, x)->
      sprite.position.x = x
      shape.translation.x = x if shape?

    @listenTo model, 'change:y', (m, y) ->
      sprite.position.y = y
      shape.translation.y = y if shape?

    @listenTo model, 'change:direction', (m, direction) ->
      if direction is 'left'
        sprite.scale.x = 0.5
      else
        sprite.scale.x = -0.5

    @listenTo model, 'change:state', @onStateChanged
    @listenTo model, 'point:in',     @onPointIn
    @listenTo model, 'point:out',    @onPointOut
    @listenTo model, 'focus:in',     @onFocusIn
    @listenTo model, 'focus:out',    @onFocusOut

    @onStateChanged model, model.get('state')

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

    @shape = shape = Fmushi.two.makeRectangle(
      @model.get('x'), @model.get('y'),
      @sprite.width * 1.1, sprite.height * 1.1
    )
    shape.stroke = '#4CBAEB'
    shape.fill = '#CCE9F9'
    shape.opacity = 1
    shape.visible = false

  animate: (name, options={}) ->
    @sprite.stop()
    @sprite.textures = @textures[name]

    if speed = @animationSpeed[name]
      @sprite.animationSpeed = speed
    @sprite.gotoAndPlay 0

  onStateChanged: (model, state) ->
    @stateMachine.to state

    animation = (if state is 'wild' then 'walking' else state)
    @animate animation

  onPointIn: (model) ->
    @shape.visible = true

  onPointOut: (model) ->
    @shape.visible = false
    