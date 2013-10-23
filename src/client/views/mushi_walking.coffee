class Fmushi.Views.MushiWalking extends Backbone.View
  initialize: -> 
    texture = PIXI.Texture.fromImage(@model.get('src'))

    sprite = new PIXI.Sprite(texture)
    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5
    sprite.position.x = @model.get('x')
    sprite.position.y = @model.get('y')
    
    sprite.interactive = true
    sprite.buttonMode = true
    sprite.scale.x = sprite.scale.y = 0.5
    
    model = @model
    @listenTo model, 'change', (model) ->
      if x = model.changed.x
        sprite.position.x = x
      if y = model.changed.y
        sprite.position.y = y

    sprite.mousedown = sprite.touchstart = (e) ->
      e.originalEvent.preventDefault()
      @event = e
      @alpha = 0.5
      @dragging = true
    
    sprite.mouseup = sprite.mouseupoutside = (e) ->
      @event = null
      @alpha = 1
      @dragging = false
    
    sprite.mousemove = sprite.touchmove = (e) ->
      if @dragging
        point = @event.getLocalPosition(@parent)
        model.set x: point.x, y: point.y
    
    Fmushi.stage.addChild sprite
