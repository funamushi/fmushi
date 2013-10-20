stage = new PIXI.Stage(0xffffff, true)
renderer = PIXI.autoDetectRenderer(1000, 1000)

texture = PIXI.Texture.fromImage("/img/funamushi.png")
funamushi = new PIXI.Sprite(texture)
funamushi.anchor.x = 0.5
funamushi.anchor.y = 0.5
funamushi.position.x = 200
funamushi.position.y = 150

funamushi.interactive = true
funamushi.buttonMode = true
funamushi.scale.x = funamushi.scale.y = 0.5

funamushi.mousedown = funamushi.touchstart = (e) ->
  e.originalEvent.preventDefault()
  @event = e
  @alpha = 0.5
  @dragging = true

funamushi.mouseup = funamushi.mouseupoutside = (e) ->
  @event = null
  @alpha = 1
  @dragging = false

funamushi.mousemove = funamushi.touchmove = (e) ->
  if @dragging
    point = @event.getLocalPosition(@parent)
    @position.x = point.x
    @position.y = point.y

stage.addChild funamushi

graphics = new PIXI.Graphics
 
graphics.beginFill(0x00FF00)
 
graphics.moveTo(0,0)
graphics.lineTo(-50, 100)
graphics.lineTo(50, 100)
graphics.endFill();
 
stage.addChild(graphics);

animate = -> 
  requestAnimFrame animate

  renderer.render stage

document.body.appendChild renderer.view
requestAnimFrame animate

