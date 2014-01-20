class Fmushi.Scenes.Login extends Fmushi.Scenes.Base
  events:
    'submit': 'submit'

  initialize: ->
    @render()
    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.html JST['login-form']()
    @

  transitionIn: ->
    defer = $.Deferred()
    @$('#login-form').addClass('in').one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
      defer.resolve()
    defer.promise()

  transitionOut: ->
    defer = $.Deferred()
    @$('#login-form').removeClass('in').one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
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
