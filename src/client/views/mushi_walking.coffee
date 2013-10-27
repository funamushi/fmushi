class Fmushi.Views.MushiWalking extends Backbone.View
  initialize: -> 
    @listenTo @model, 'change', @onMove

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

    sprite.interactive = true
    sprite.buttonMode = true
  
    # TODO: モデルの半径を元に計算したい
    sprite.scale.x = @sprite.scale.y = 0.5
    
    model = @model

    sprite.mousedown = @sprite.touchstart = (e) ->
      e.originalEvent.preventDefault()
      @event = e
      @dragging = true
    
    sprite.mouseup = @sprite.mouseupoutside = (e) ->
      @event = null
      @dragging = false
    
    sprite.mousemove = @sprite.touchmove = (e) ->
      if @dragging
        worldPos = @event.getLocalPosition(Fmushi.stage)
        model.set x: worldPos.x, y: worldPos.y
    
    text = new PIXI.Text "スポンサー広告ぼ集中",
      font: 'bold 16pt Arial'
      fill: 'white'
    text.anchor.x = 0.5
    text.anchor.y = 0.5
    text.position.x = 0
    text.position.y = -20

    sprite.addChild text

    Fmushi.stage.addChild sprite

  onMove: ->
    if x = @model.changed.x
      @sprite.position.x = x
      @debugShape.translation.x = x if @debugShape

    if y = @model.changed.y
      @sprite.position.y = y
      @debugShape.translation.y = y if @debugShape
