class Fmushi.Scenes.Base extends Fmushi.Views.Base
  el: '#content'

  keepElement: true

  constructor: ->
    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    @$indicator = $indicator = $('#indicator').show()

    @on 'load:complete', =>
      header = new Fmushi.Views.Header
      header.render()
      @subview 'header', header
      $indicator.hide()

      @$navigates = $navigate = @$('a.navigate')
      $navigate.on 'click', (e) ->
        e.preventDefault()
        Backbone.history.navigate $(e.target).attr('href'), trigger: true

    super
    @$el.empty()

  dispose: ->
    @$indicator.show()
    @$navigates.off 'click'

    super
    Fmushi.stage.removeChild @world
    Fmushi.two.remove @shapeWorld    

