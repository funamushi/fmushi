class Fmushi.Scenes.Signup extends Fmushi.Scenes.Base
  initialize: (options) ->
    @trigger 'load:complete'

    texture = PIXI.Texture.fromFrame('iwa2.png')
    iwa = new PIXI.Sprite texture

    iwa.anchor.x = 0.5
    iwa.anchor.y = 0.5
    iwa.position.x = Fmushi.screenCenter().x
    iwa.position.y = Fmushi.screenCenter().y
    @world.addChild iwa

  