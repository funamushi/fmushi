class Fmushi.Scenes.Login extends Fmushi.Scenes.Base
  events:
    'submit': 'submit'

  initialize: ->
    @render()
    setTimeout ( => @trigger 'ready'), 0

  render: ->
    @$el.addClass('slide').html JST['login-form']()
    @

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
