class Fmushi.Views.MushiWalking extends Backbone.View
  initialize: -> 
    @listenTo @model, 'change',     @onChanged
    @listenTo @model, 'point:in',   @onPointIn
    @listenTo @model, 'point:out',  @onPointOut
    @listenTo @model, 'focus:in',   @onFocusIn
    @listenTo @model, 'focus:out',  @onFocusOut

    @pointShape = shape = Fmushi.two.makeRectangle(
      @model.get('x'), @model.get('y'), @model.get('r') * 2.5, @model.get('r') * 1.5
    )
    shape.stroke = '#4CBAEB'
    shape.fill = '#CCE9F9'
    shape.opacity = 0.5
    shape.visible = false
    Fmushi.app.shapeWorld.add shape

    textures = (PIXI.Texture.fromFrame("mushi_walk-#{i}.png") for i in [1..3])
    @sprite = sprite = new PIXI.MovieClip(textures)
    sprite.animationSpeed = 0.075
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

    sprite.click = sprite.tap = (e) => 
      Fmushi.app.hitSprite = sprite
      Fmushi.app.focus @model

    @listenTo Fmushi.Events, 'update', ->
      x = @model.get('x')
      if @model.get('direction') == 'left'
        if x < -10
          @model.set direction: 'right'
        else
          @model.set x: x - 0.5
      else
        if x > 1000
          @model.set direction: 'left'
        else
          @model.set x: x + 0.5

    Fmushi.app.world.addChild sprite

  onChanged: ->
    if x = @model.changed.x
      @sprite.position.x = x
      @pointShape.translation.x = x if @pointShape

    if y = @model.changed.y
      @sprite.position.y = y
      @pointShape.translation.y = y if @pointShape

    if d = @model.changed.direction
      if d == 'left'
        @sprite.scale.x = 0.5
      else
        @sprite.scale.x = -0.5

  onPointIn: (model) ->
    @pointShape.visible = true

  onPointOut: (model) ->
    @pointShape.visible = false
