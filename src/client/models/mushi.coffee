class Fmushi.Models.Mushi extends Backbone.Model
  Object.defineProperties @prototype,
    circle:
      get: -> @_cirlce
      set: (val) ->
        @_circle = val
        @set 'circleId', val?.get('id')

  defaults: ->
    src: "/img/funamushi.png"
    x: 0
    y: 0
    groth: 1
    rankId: 1
    direction: 'left'

  initialize: ->
    @r = 30 * @get('groth') # body
    @equipments ?= new Fmushi.Collections.Equipments

  set: (key, val, options) ->
    if typeof key is 'object'
      attrs = key
      options = val
    else
      (attrs = {})[key] = val

    @rank = Fmushi.ranks.get(attrs.rankId)

    equipments = attrs.equipments
    @equipments ?= new Fmushi.Collections.Equipments
    @equipments.reset attrs.equipments
    delete attrs.equipments

    super attrs, options

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
  