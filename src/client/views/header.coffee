class Fmushi.Views.Header extends Fmushi.Views.Base
  el: '#site-header nav'

  events:
    'click #login': 'login'

  initialize: (options) ->
    viewer = Fmushi.viewer
    @listenTo viewer, 'change:fp', ->
      @$('#fp').text viewer.get('fp')

  render: ->
    signinHidden = !!Backbone.history.fragment.match(/register|login/)

    @$el.html JST['header']
      viewer: Fmushi.viewer.toJSON()
      authorized: Fmushi.viewer.authorized
      signinHidden: signinHidden
    @

  login: (e) ->
    e.preventDefault()
    Backbone.history.navigate '/signin'