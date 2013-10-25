class Fmushi.Views.MushiWalking extends Backbone.View
  initialize: -> 
    attrs = @model.attributes

    @debugShape = Fmushi.two.makeCircle attrs.x, attrs.y, attrs.r
    @debugShape.stroke = 'orangered'
    @debugShape.noFill()

    texture = PIXI.Texture.fromImage attrs.src

    @sprite = sprite = new PIXI.Sprite(texture)
    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5
    sprite.position.x = attrs.x
    sprite.position.y = attrs.y

    sprite.interactive = true
    sprite.buttonMode = true
    sprite.scale.x = @sprite.scale.y = 0.5
    
    model = @model
    @listenTo model, 'change', @onMove

    sprite.mousedown = @sprite.touchstart = (e) ->
      e.originalEvent.preventDefault()
      @event = e
      @alpha = 0.5
      @dragging = true
    
    sprite.mouseup = @sprite.mouseupoutside = (e) ->
      @event = null
      @alpha = 1
      @dragging = false
    
    sprite.mousemove = @sprite.touchmove = (e) ->
      if @dragging
        point = @event.getLocalPosition(@parent)
        model.set x: point.x, y: point.y
    
    Fmushi.stage.addChild sprite

  onMove: ->
    if x = @model.changed.x
      @sprite.position.x = x
      @debugShape.translation.x = x

    if y = @model.changed.y
      @sprite.position.y = y
      @debugShape.translation.y = y
