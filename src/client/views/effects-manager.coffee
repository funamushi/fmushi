class EffectsManager
  initialize: ->
    funaTexture = PIXI.Texture.fromFrame('funa.png')
    funaPools = for i in [0..10]
      sprite = new PIXI.Sprite funaTexture
      sprite.visible = false
      sprite

  funaAt: (x, y) ->
    if _.osObject x
      x = x.x
      y = y.y

    