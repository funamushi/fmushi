class Fmushi.Views.MushiesPanel extends Fmushi.Views.Base
  el: '#mushies-panel'

  events:
    'mouseover a': 'point'
    'mouseout a':  'pointOut'
    'click a': 'focus'
    'tap a':   'focus'

  initialize: (options) ->
    @user = options.user

    @listenTo @collection, 'focus:in', (mushi) ->
      @$('.list-group-item').each ->
        $this = $(@)
        if $this.data('mushi-id') is mushi.get('id')
          $this.addClass 'active'
        else
          $this.removeClass 'active'

    @listenTo @collection, 'focus:out', ->
      @$('.list-group-item').removeClass('active')

    @listenTo @user, 'change', (user) =>
      @$fp.text user.get('fp')

  render: ->
    mushies = @collection.map (mushi) ->
      attr = mushi.toJSON()
      attr.rank = mushi.rank.toJSON()
      attr

    @$el.html JST['mushies/panel']
      mushies: mushies
    @$fp = @$('#fp')
    @

  point: (e) ->
    mushi = @mushiFromEvent(e)?.point()

  pointOut: (e) ->
    @mushiFromEvent(e)?.pointOut()

  focus: (e) ->
    e.preventDefault()
    mushi = @mushiFromEvent(e)
    Backbone.history.navigate mushi.url(), trigger: true

  mushiFromEvent: (e) ->
    mushiId = $(e.target).data('mushi-id')
    @collection.findWhere(id: mushiId)
