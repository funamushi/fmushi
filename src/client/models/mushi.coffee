class Fmushi.Models.Mushi extends Backbone.Model
  Object.defineProperties @prototype,
    circle:
      get: -> @_circle
      set: (val) ->
        @_circle = val
        @set 'circleId', (val?.get('id') or null)

  defaults: ->
    src: "/img/funamushi.png"
    x: 0
    y: 0
    groth: 1
    rankId: 1
    direction: 'left'

  initialize: ->
    @r = 30 * @get('groth') # body

    @rank       = Fmushi.ranks.get(@get 'rankId')
    @equipments = new Fmushi.Collections.Equipments(@get 'equipments')

    @on 'change:rankId', (model, val) =>
      @rank = Fmushi.ranks.get(val)

  pos: ->
    new Fmushi.Vector @get('x'), @get('y')

  comment: ->
    _.sample [
      '右折しま〜す'
      '左折しま〜す'
      '大は小を兼ねるって言うし'
      '風来てる、風来てる'
      '酸素うまい'
    ]

  point: ->
    @trigger 'point:in'

  pointOut: ->
    @trigger 'point:out'
  