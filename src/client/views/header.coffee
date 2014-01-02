class Fmushi.Views.Header extends Fmushi.Views.Base
  el: '#site-header nav'

  initialize: (options) ->
    viewer = Fmushi.viewer
    @listenTo viewer, 'change:fp', ->
      @$('#fp').text viewer.get('fp')

  render: ->
    @$el.html JST['header'](viewer: Fmushi.viewer.toJSON())
    @
    