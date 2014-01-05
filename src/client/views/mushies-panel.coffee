class Fmushi.Views.MushiesPanel extends Fmushi.Views.Base
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

  render: ->
    mushies = @collection.map (mushi) ->
      attr = mushi.toJSON()
      attr.rank = mushi.rank.toJSON()
      attr

    @setElement JST['mushies/panel']
      mushies: mushies
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
