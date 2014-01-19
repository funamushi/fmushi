class Fmushi.Scenes.Base extends Fmushi.Views.Base
  constructor: ->
    @world = world = new PIXI.DisplayObjectContainer
    Fmushi.stage.addChild world
    @shapeWorld = shapeWorld = Fmushi.two.makeGroup()

    @setElement $(document.createElement('div'))
    .appendTo('#content')
    .addClass('scene')

    $('#indicator').show()

    @on 'ready', =>
      $('#indicator').hide()

      @$navigates = $navigate = @$('a.navigate')
      $navigate.on 'click', (e) ->
        e.preventDefault()
        Backbone.history.navigate $(e.target).attr('href'), trigger: true

    super

  transitionIn: ->
    defer = $.Deferred()
    @$el.addClass('in').one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
      defer.resolve()
    defer.promise()

  transitionOut: ->
    defer = $.Deferred()
    @$el.removeClass('in').one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
      defer.resolve()
    defer.promise()

  dispose: ->
    @$navigates.off 'click'

    super

    Fmushi.stage.removeChild @world
    Fmushi.two.remove @shapeWorld    

