class Fmushi.Views.Header extends Fmushi.Views.Base
  el: '#site-header nav'

  events:
    'click #login': 'login'
    'click #logout': 'logout'

  initialize: (options) ->
    viewer = Fmushi.viewer
    @listenTo viewer, 'change:fp', ->
      @$('#fp').text viewer.get('fp')

  render: ->
    loginHidden = !!Backbone.history.fragment.match(/register|login/)

    @$el.html JST['header']
      viewer: Fmushi.viewer.toJSON()
      authorized: Fmushi.viewer.authorized
      loginHidden: loginHidden
    @

  login: (e) ->
    e.preventDefault()
    Backbone.history.navigate '/login', trigger: true

  logout: (e) ->
    e.preventDefault()
    if confirm 'ログアウトする？'
      console.log 'logout'
    