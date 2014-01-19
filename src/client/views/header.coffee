class Fmushi.Views.Header extends Fmushi.Views.Base
  el: '#site-header nav'

  events:
    'click #login': 'login'
    'click #logout': 'logout'

  initialize: (options) ->
    model = @model

    @listenTo model, 'change:fp', =>
      @$('#fp').text model.get('fp')

    @listenTo model, 'login', =>
      @render()

    @listenTo model, 'logout', =>
      @render()

  render: ->
    @$el.html JST['header']
      viewer: @model.toJSON()
      loggedIn: @model.loggedIn
    @

  login: ->

  logout: ->
    if confirm 'ログアウトする?'
      Backbone
      .ajax
        dataType: 'json'
        type: 'DELETE'
        url: '/logout'
      .done =>
        Backbone.history.navigate '/login', trigger: true
        @model.logout()
        