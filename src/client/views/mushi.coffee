Fmushi   = require 'fmushi'
BaseView = require 'views/base'
MushiStateMachine = require 'models/mushi-state-machine'

module.exports = class MushiView extends BaseView
  animationSpeed:
    wild:    0.55
    walking: 0.20

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
    @listenTo model, 'zoom:in',     @onFocusIn
    @listenTo model, 'zoom:out',    @onFocusOut

    @onStateChanged model, model.get('state')

  initSprite: ->
    @textures = {}

    slug = @model.get('breed.slug')
    @textures.walking = _.map [
      "mushi-#{slug}_walk-1-0.png"
      "mushi-#{slug}_walk-1-1.png"
      "mushi-#{slug}_walk-2-0.png"
      "mushi-#{slug}_walk-2-1.png"
    ], (name) -> PIXI.Texture.fromFrame(name)
    @textures.wild = @textures.walking

    @textures.idle = idleTextures = [
      PIXI.Texture.fromFrame("mushi-#{slug}_idle.png")
      ]
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

    sprite.click = sprite.tap = (e) =>
      Fmushi.currentScene.zoom @model, clickCancel: true

    @shape = shape = Fmushi.two.makeRectangle(
      @model.get('x'), @model.get('y'),
      @sprite.width * 1.1, sprite.height * 1.1
    )
    shape.stroke = '#4CBAEB'
    shape.fill = '#CCE9F9'
    shape.opacity = 0.5
    shape.visible = false

  animate: (name, options={}) ->
    @sprite.stop()
    @sprite.textures = @textures[name]

    if speed = @animationSpeed[name]
      @sprite.animationSpeed = speed
    @sprite.gotoAndPlay 0

  onStateChanged: (model, state) ->
    @stateMachine.to state
    @animate state

  onPointIn: (model) ->
    @shape.visible = true

  onPointOut: (model) ->
    @shape.visible = false
    