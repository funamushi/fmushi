class Fmushi.Views.Walker extends Backbone.View
  initialize: -> 
    texture = PIXI.Texture.fromImage("/img/funamushi.png")

    sprite = new PIXI.Sprite(texture)
    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5
    sprite.position.x = 200
    sprite.position.y = 150
    
    sprite.interactive = true
    sprite.buttonMode = true
    sprite.scale.x = sprite.scale.y = 0.5
    
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
        @position.x = point.x
        @position.y = point.y
    
    Fmushi.stage.addChild sprite
