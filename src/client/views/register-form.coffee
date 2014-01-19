class Fmushi.Views.RegisterForm extends Fmushi.Views.Base
  events:
    'click #username-ok': 'usernameOk'

  render: ->
    @setElement JST['register-form']()
    @

  submit: (e) ->
    e.preventDefault()

    Backbone
    .ajax
      dataType: 'json'
      type: 'POST'
      url: '/register'
      data: @$('form').serialize()
    .done (data) ->
      viewer = Fmushi.viewer
      viewer.login data
      Backbone.history.navigate viewer.url(), trigger: true
  