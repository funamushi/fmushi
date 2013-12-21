class Fmushi.EffectsManager
  constructor: ->
    @spritePools = {}

    @addSpritePool 'funa.png', 10

  funa: (x, y) ->
    if _.isObject x
      x = x.x
      y = y.y

    sprite = @spriteFromPool 'funa.png'
    sprite.position.x = x
    sprite.position.y = y

  spriteFromPool: (frameId) ->
    @spritePools[frameId] ?= []

    sprite = _.detect @spritePools[name], (v) ->
      !v.visible
    unless sprite?
      sprite = @addSpritePool frameId
    sprite.visible = true
    sprite

  addSpritePool: (frameId, count=1) ->
    @spritePools[frameId] ?= []

    unless frameId?
      sprite = _.detect @spritePools[name], (v) ->
        !v.visible
      return sprite if sprite?
        
    texture = PIXI.Texture.fromFrame(frameId)
    for i in [0..count]
      sprite = new PIXI.Sprite texture
      sprite.visible = false
      Fmushi.scene.world.addChild sprite
    sprite