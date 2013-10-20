stage = new PIXI.Stage(0x66FF99)
renderer = PIXI.autoDetectRenderer(400, 300)

texture = PIXI.Texture.fromImage("/img/funamushi.png")
funamushi = new PIXI.Sprite(texture)
funamushi.anchor.x = 0.5
funamushi.anchor.y = 0.5
funamushi.position.x = 200
funamushi.position.y = 150
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

  funamushi.rotation += 0.1

  renderer.render stage

document.body.appendChild renderer.view
requestAnimFrame animate

