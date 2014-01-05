class Fmushi.Scenes.Base extends Fmushi.Views.Base
  el: 'body'

  constructor: ->
    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    @on 'load:complete', =>
      @$indicator = $indicator = @$('#indicator').show()

      header = new Fmushi.Views.Header
      header.render()
      @subview 'header', header
      $indicator.hide()

      @$navigates = $navigate = @$('a.navigate')
      $navigate.on 'click', (e) ->
        e.preventDefault()
        Backbone.history.navigate $(e.target).attr('href'), trigger: true

    super

  dispose: ->
    @$indicator.show()

    @$navigates.off 'click'

    super
    Fmushi.stage.removeChild @world
    Fmushi.two.remove @shapeWorld    

