class Fmushi.Views.MushiWalking extends Backbone.View
  initialize: -> 
    @listenTo @model, 'change', @onMove

    loader = new PIXI.AssetLoader ['/app.json']
    loader.onComplete = _.bind @onAssetLoaded, @, loader
    loader.load()

  onAssetLoaded: (loader) ->
    textures = (PIXI.Texture.fromFrame("mushi_walk-#{i}.png") for i in [1..3])

    @sprite = sprite = new PIXI.MovieClip(textures)
    sprite.animationSpeed = 0.05
    sprite.gotoAndPlay 0

    attrs = @model.attributes
    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5
    sprite.position.x = attrs.x
    sprite.position.y = attrs.y

    sprite.interactive = true
    sprite.buttonMode = true
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
    
    Fmushi.stage.addChild sprite

  onMove: ->
    if x = @model.changed.x
      @sprite.position.x = x

    if y = @model.changed.y
      @sprite.position.y = y
