class Fmushi.Views.LoginForm extends Fmushi.Views.Base
  events:
    'submit': 'submit'

  initialize: (options={}) ->
    @isRegister = options.isRegister

  render: ->
    @setElement JST['login-form']()
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
  