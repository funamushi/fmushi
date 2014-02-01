class Fmushi.Scenes.Login extends Fmushi.Scenes.Base
  events:
    'submit': 'submit'

  initialize: ->
    @render()
    @$el.css(transformOrigin: '10px 10px', rotateX: '180deg')
    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.html JST['login-form']()
    @

  transitionIn: ->
    defer = $.Deferred()
    @$el.transition perspective: '1000px', rotateX: '0deg', =>
      @$el.attr 'style', ''
      defer.resolve()
    defer.promise()

  transitionOut: ->
    defer = $.Deferred()
    @$el.transition perspective: '1000px', rotateX: '100deg', ->
      defer.resolve()
    defer.promise()

  submit: (e) ->
    e.preventDefault()

    Backbone
    .ajax
      dataType: 'json'
      type: 'POST'
      url: '/login'
      data: @$('form').serialize()
    .done (data) ->
      viewer = Fmushi.viewer
      viewer.login data
      Backbone.history.navigate viewer.url(), trigger: true
