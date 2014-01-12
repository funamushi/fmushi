class Fmushi.Models.Mushi extends Backbone.Model
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

    rankId = attrs.rankId
    unless _.isUndefined(rankId)
      @rank = Fmushi.ranks.get(rankId)

    equipments = attrs.equipments
    unless _.isUndefined(equipments)
      @equipments ?= new Fmushi.Collections.Equipments
      @equipments.reset equipments
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
  