class Fmushi.Views.World extends Backbone.View
  initialize: ->
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

    Fmushi.stage.addChild funamushi

    circle = Fmushi.two.makeCircle(
      Fmushi.two.width / 2,
      Fmushi.two.height / 2,
      Fmushi.two.height / 3
      )

    circle.linewidth = 1
    circle.noFill()
