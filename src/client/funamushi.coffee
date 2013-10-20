stage = new PIXI.Stage(0xffffff, true)
renderer = PIXI.autoDetectRenderer(400, 300)

texture = PIXI.Texture.fromImage("/img/funamushi.png")
funamushi = new PIXI.Sprite(texture)
funamushi.anchor.x = 0.5
funamushi.anchor.y = 0.5
funamushi.position.x = 200
funamushi.position.y = 150

funamushi.setInteractive(true)
funamushi.mouseover = (e) ->
  console.log e

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

