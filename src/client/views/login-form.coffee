class Fmushi.Views.LoginForm extends Fmushi.Views.Base
  events:
    'submit': 'submit'

  initialize: (options={}) ->
    @isRegister = options.isRegister

  render: ->
    @setElement JST['login-form'] isRegister: @isRegister
    @

  submit: (e) ->
    e.preventDefault()

    url = (if @isRegister then '/register' else '/login')

    Backbone
    .ajax
      dataType: 'json'
      type: 'POST'
      url: url
      data: @$('form').serialize()
    .done (data) ->
      viewer = Fmushi.viewer
      viewer.set data, aurhorized: true
      console.log viewer.aurhorized
      console.log viewer.url()
      Backbone.history.navigate viewer.url(), trigger: true
  