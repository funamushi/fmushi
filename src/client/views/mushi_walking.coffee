class Fmushi.Views.MushiWalking extends Backbone.View
  initialize: -> 
    @listenTo @model, 'change', @onChanged

    if Fmushi.debug
      @debugShape = Fmushi.two.makeCircle @model.get('x'), @model.get('y'), @model.get('r')
      @debugShape.stroke = 'orangered'
      @debugShape.noFill()

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

    model = @model
    sprite.mousedown = @sprite.touchstart = (e) ->
      console.log e
      Fmushi.app.focus model

    @listenTo Fmushi.Events, 'update', ->
      x = @model.get('x')
      if @model.get('direction') == 'left'
        if x < -10
          @model.set direction: 'right'
        else
          @model.set x: x - 1
      else
        if x > 1000
          @model.set direction: 'left'
        else
          @model.set x: x + 1

    Fmushi.app.world.addChild sprite

  onChanged: ->
    if x = @model.changed.x
      @sprite.position.x = x
      @debugShape.translation.x = x if @debugShape

    if y = @model.changed.y
      @sprite.position.y = y
      @debugShape.translation.y = y if @debugShape

    if d = @model.changed.direction
      if d == 'left'
        @sprite.scale.x = 0.5
      else
        @sprite.scale.x = -0.5


