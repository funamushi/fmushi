class Fmushi.Views.LoginForm extends Fmushi.Views.Base
  events:
    'submit #register': 'register'
    'submit #login': 'login'

  initialize: (options={}) ->
    @isRegister = options.isRegister

  render: ->
    @setElement JST['login-form'] isRegister: @isRegister
    @

  register: (e) ->
    e.preventDefault()

  login: (e) ->
    e.preventDefault()
  