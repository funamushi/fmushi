class Fmushi.Views.Header extends Fmushi.Views.Base
  el: '#site-header nav'

  initialize: (options) ->
    @viewer = options.viewer

    @listenTo @viewer, 'change:fp', ->
      @$('#fp').text @viewer.get('fp')

  render: ->
    @$el.html JST['header'](viewer: @viewer.toJSON())
    @
    