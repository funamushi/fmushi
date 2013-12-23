class Fmushi.Scenes.Base extends Fmushi.Views.Base
  constructor: ->
    @$indicator = $indicator = $('#indicator').show()

    @on 'load:complete', ->
      $indicator.hide()

    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    super

  onNavigate: (options) ->

  dispose: ->
    @$indicator.show()

    super
    Fmushi.stage.removeChild @world
    Fmushi.two.remove @shapeWorld    

      